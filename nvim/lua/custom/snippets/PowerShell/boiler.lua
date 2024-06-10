---@diagnostic disable: undefined-global
return {
    -- standard template
    s(
        {
            trig = "boiler",
            name = "boilerplate",
            dscr = "boilerplate",
        },
        fmt(
            [[
                <#
                .SYNOPSIS
                {syn}

                .DESCRIPTION
                {desc}
                #>

                function Write-Log {{
                    [CmdletBinding()]
                    param(
                        [Parameter()]
                        [ValidateSet("info", "warn", "error", "debug", "verb")]
                        [string]
                        $Level = "info",

                        [Parameter(Mandatory, ValueFromPipeline)]
                        $Message,

                        [Parameter()]
                        [switch]
                        $AddToLogFile,

                        [Parameter()]
                        [switch]
                        $AddToErrorList
                    )

                    BEGIN {{
                        $stamp = Get-Date -UFormat '+%Y-%m-%dT%T%Z'
                        $caller = (Get-PSCallStack)[1].Command
                        if ($caller -match 'ScriptBlock') {{
                            $caller = Split-Path -Path $PSCommandPath -Leaf
                        }}
                    }}

                    PROCESS {{
                        $full = @(
                            $stamp,
                            $level.ToUpper(),
                            $caller,
                            $Message.ToString()
                        ) -join '|'

                        $short = @($caller, $Message.ToString()) -join '|'

                        if ($AddToErrorList) {{
                            $ErrorList += @($short)
                        }}

                        if ($AddToLogFile -and $null -ne $LogFile) {{
                            Add-Content -Path $LogFile -Value $full
                        }}

                        switch ($Level.ToLower()) {{
                            'info' {{ Write-Host $short }}
                            'warn' {{ Write-Warning -Message $short }}
                            'error' {{ Write-Error -Message $short }}
                            'debug' {{ Write-Debug -Message $short }}
                            'verb' {{ Write-Verbose -Message $full }}
                        }}
                    }}
                }}

                function Send-EmailNotification {{
                    [CmdletBinding()]
                    param(
                        [Parameter()]
                        [string]
                        $Subject = "$(Split-Path -Path $PSCommandPath -Leaf) Failed",

                        [Parameter(ValueFromPipeline, Position = 0)]
                        [string]
                        $Message = 'N/A'
                    )

                    BEGIN {{
                        $me = Split-Path -Path $PSCommandPath -Leaf
                        $name = [System.IO.Path]::GetFileNameWithoutExtension($PSCommandPath)

                        $text = @("Host: $env:COMPUTERNAME")

                        $params = @{{
                            Uri = 'https://api.mailgun.net/v3/{dom1}/messages'
                            Body = @{{
                                from = "$me <$name@{dom2}>"
                                to = "{addr}"
                                subject = $Subject
                                text = ""
                            }}
                            Credential = [System.Management.Automation.PSCredential]::new(
                                {user},
                                (ConvertTo-SecureString -String {key} -AsPlainText -Force)
                            )
                            Method = 'POST'
                            ErrorAction = 'Ignore'
                        }}
                    }}

                    PROCESS {{
                        $text += @($Message)
                    }}

                    END {{
                        $params['Body']['text'] = $text
                        Invoke-RestMethod @params {logged}
                    }}
                }}

                function Send-ToastNotification {{
                    [CmdletBinding()]
                    param(
                        [Parameter(Mandatory)]
                        [string]
                        $Subject,

                        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
                        [string]
                        $Message
                    )

                    BEGIN {{
                        $me = [System.IO.Path]::GetFileNameWithoutExtension($PSCommandPath)

                        [Windows.UI.Notifications.ToastNotificationsManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
                        $template = [Windows.UI.Notifications.ToastNotificationsManager]::GetTemplateContent(
                            [Windows.UI.Notifications.GetTemplateType]::ToastText02
                        )

                        $raw = [xml] $template.GetXml()

                        ($raw.toast.visual.binding.text | Where-Object {{
                            $_.id -eq 1
                        }}).AppendChild($raw.CreateTextNode($Subject)) | Out-Null
                    }}

                    PROCESS {{
                        $raw = [xml] $template.GetXml()

                        ($raw.toast.visual.binding.text | Where-Object {{
                            $_.id -eq 2
                        }}).AppendChild($raw.CreateTextNode($Message)) | Out-Null
                    }}

                    END {{
                        $serial = [Windows.Data.Xml.Dom.XmlDocument]::new()
                        $serial.LoadXml($raw.OuterXml)

                        $toast = [Windows.UI.Notifications.ToastNotification]::new($serial)
                        $toast.Tag = $me
                        $toast.Group = $me
                        $toast.ExpirationTime = [DateTimeOffset]::Now.AddMinutes(1)

                        $notifier = [Windows.UI.Notifications.ToastNotificationsManager]::CreateToastNotifier($me)
                        $notifier.Show($toast)
                    }}
                }}

                function New-LogFile {{
                    $params = @{{
                        Path = "{parent}"
                        ItemType = 'File'
                        Name = ([System.IO.FileInfo] $PSCommandPath).BaseName + '.log'
                        Force = $True
                        ErrorAction = 'Ignore'
                    }}

                    $p = Join-Path -Path $params['Path'] -ChildPath $params['Name']

                    if (Test-Path -Path $p -PathType Leaf) {{
                        return (Get-Item -Path $p)
                    }}

                    New-Item @params
                }}

                {run}
            ]],
            {
                syn = i(1, "synopsis"),
                desc = i(2, "description"),
                dom1 = i(3, "company.domain"),
                dom2 = rep(3),
                addr = i(4, "recipient"),
                user = i(5, "api-user"),
                key = i(6, "api-key"),
                logged = c(7, {
                    t(""),
                    t("| Write-Log -Level 'verb' -AddToLogFile"),
                }),
                parent = i(8, "C:\\path\\to\\parent"),
                run = i(0),
            }
        )
    ),
    -- psm1 template
    s(
        {
            trig = "psm1",
            name = "psm1 template",
            dscr = "PS Module template",
        },
        fmt(
            [[
                #!/usr/bin/env pwsh

                #. "$PSScriptRoot/Imports.ps1"

                $itemSplat = @{{
                    Filter      = '*.ps1'
                    Recurse     = $true
                    ErrorAction = 'Stop'
                }}

                try {{
                    $public = @(Get-ChildItem -Path "$PSScriptRoot/Public" @itemSplat)
                    $private = @(Get-ChildItem -path "$PSScriptRoot/Private" @itemSplat)
                }} catch {{
                    Write-Error $_
                    throw "Unable to get file information from Public & Private src."
                }}

                foreach ($file in @($public + $private)) {{
                    try {{
                        . $file.FullName
                    }} catch {{
                        throw "Unable to dot-source [$($file.FullName)]"
                    }}
                }}

                Export-ModuleMember -Function $public.Basename
            ]],
            {}
        )
    ),
}

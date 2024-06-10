---@diagnostic disable: undefined-global
return {
    -- legacy help function
    s(
        {
            trig = "show_help()",
            name = "legacy help",
            dscr = "legacy help function",
        },
        fmt(
            [[
                function Write-Help {{
                    Write-Host @"
                {synopsis}

                USAGE: $(Split-Path -Path $PSCommandPath -Leaf) [OPTIONS]

                OPTIONS:
                    -Help               Show this help message
                    {opts}
                "@
                }}
            ]],
            {
                synopsis = i(1, "synopsis"),
                opts = i(0),
            }
        )
    ),

    -- "basic" logging
    s(
        {
            trig = "log()",
            name = "logging",
            dscr = "traditional logging",
        },
        fmt(
            [[
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
            ]],
            {}
        )
    ),

    -- Send email notification
    s(
        {
            trig = "email_notif()",
            name = "email notification",
            dscr = "email notification",
        },
        fmt(
            [[
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
            ]],
            {
                dom1 = i(1, "company.domain"),
                dom2 = rep(1),
                addr = i(2, "recipient"),
                user = i(3, "api-user"),
                key = i(4, "api-key"),
                logged = c(5, {
                    t(""),
                    t("| Write-Log -Level 'verb' -AddToLogFile"),
                }),
            }
        )
    ),

    -- Send toast notification
    s(
        {
            trig = "toast_notif()",
            name = "toast notification",
            dscr = "toast notification",
        },
        fmt(
            [[
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
            ]],
            {}
        )
    ),

    -- new LogFile
    s(
        {
            trig = "new_log()",
            name = "gen log file",
            dscr = "generate and/or return logfile object",
        },
        fmt(
            [[
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
            ]],
            {
                parent = i(1, "C:\\path\\to\\parent"),
            }
        )
    ),

    -- is_admin() (if #Requires isn't available)
    s(
        {
            trig = "is_admin()",
            name = "is administrator func",
            dscr = "is administrator function",
        },
        fmt(
            [[
                function Test-IsAdministrator {{
                    $win = [System.Security.Principal.WindowsIdentity]::GetCurrent()
                    $id = [System.Principal.WindowsPrincipal] $win

                    $role = [Security.Principal.WindowsBuiltInRole] "Administrator"

                    return $id.IsInRole($role)
                }}
            ]],
            {}
        )
    ),

    -- parse ini-file to psobject
    s(
        {
            trig = "parse_ini()",
            name = "parse ini file",
            dscr = "parse ini file to table",
        },
        fmt(
            [[
                function Import-Ini {{
                    [CmdletBinding()]
                    param(
                        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
                        [ValidateScript({{Test-Path -Path $_ -PathType Leaf}})]
                        [string]
                        $Path
                    )

                    BEGIN {{
                        $section = "NO_SECTION"
                        $ini = @{{
                            Comments = @()
                        }}
                    }}

                    PROCESS {{
                        switch -regex -file $Path {{
                            '^\s\[(.*)\]\s*$' {{
                                $section = $Matches[1].Trim()
                                $ini[$section] = [PSCustomObject]@{{
                                    Comments = @()
                                }}
                            }}

                            '^\s*;' {{
                                $ini[$section].Comments += @(
                                    ($str -replace '^\s*;', '').Trim()
                                )
                            }}

                            '^(^=]+?)=(.*)' {{
                                $member = @{{
                                    InputObject = $ini[$section]
                                    MemberType  = 'NoteProperty'
                                    Name        = $Matches[1].Trim()
                                    Value       = $Matches[2].Trim()
                                    Force       = $True
                                }}

                                if ($Matches[2].IndexOfAny(';') -ne -1) {{
                                    $ini[$section].Comments += @(
                                        ($member['Value'] -replace '^[^;]+?;', '').Trim()
                                    )
                                    $member['Value'] = ($member['Value'] -replace ';.*', '').Trim()
                                }}

                                Add-Member @member
                            }}
                        }}
                    }}

                    END {{
                        return $ini
                    }}
                }}
            ]],
            {}
        )
    ),
}

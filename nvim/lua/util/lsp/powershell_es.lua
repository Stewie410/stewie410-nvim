local M = {}

function M.make_cmd(bundle)
  local cache = vim.fn.stdpath("cache")
  local args = {
    "&",
    "'%s/PowerShellEditorServices/Start-EditorServices.ps1'",
    "-BundledModulesPath '%s'",
    "-LogPath '%s/powershell_es.log'",
    "-SessionDetailsPath '%s/powershell_es.session.json'",
    "-FeatureFlags @()",
    "-AdditionalModules @()",
    "-HostProfileId 0",
    "-HostVersion 1.0.0",
    "-LogLevel Normal",
  }
  local command = table.concat(args, " "):format(bundle, bundle, cache, cache)
  return { "pwsh", "-NoLogo", "-NoProfile", "-Command" }
end

return M

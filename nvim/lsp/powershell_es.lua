local function make_cmd(bundle)
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
  return {
    "pwsh",
    "-NoLogo",
    "-NoProfile",
    "-Command",
    table.concat(args, " "):format(bundle, bundle, cache, cache),
  }
end

return {
  cmd = make_cmd(vim.fs.joinpath(vim.env.HOME, "git", "lsp", "PowerShellEditorServices", "bin")),
  filetypes = { "ps1", "powershell" },
  root_markers = {
    "PSScriptAnalyzerSettings.psd1",
    "*.psm1",
    "*.psd1",
    ".git",
    ".svn",
  },
}

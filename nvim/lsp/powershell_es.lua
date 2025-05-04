---@return string|nil
local function bundle_path()
  local candidates = {
    mason = { vim.fs.stdpath("state"), "mason", "packages", "powershell-editor-services" },
    user = { vim.env.HOME, "git", "lsp", "PowerShellEditorServices", "bin" },
  }

  for _, v in pairs(candidates) do
    local path = vim.fs.joinpath(unpack(v))
    if vim.uv.fs_stat(path) then
      return path
    end
  end

  error("lsp.powershell_es: Cannot determine bundle path!")
end

local function lsp_cmd(dispatchers)
  local cache = vim.fn.stdpath("cache")
  local bundle = vim.lsp.config.powershell_es.bundle_path
  local shell = vim.lsp.config.powershell_es.shell or "pwsh"

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
  local cmd = { shell, "-NoLogo", "-NoProfile", "-Command", command }

  return vim.lsp.rcp.start(cmd, dispatchers)
end

return {
  cmd = lsp_cmd,
  bundle_path = bundle_path(),
  shell = "pwsh",
  filetypes = { "ps1", "powershell" },
  root_markers = {
    "PSScriptAnalyzerSettings.psd1",
    "*.psm1",
    "*.psd1",
    ".git",
    ".svn",
  },
}

local util = require("util.lsp.powershell_es")

return {
  cmd = util.make_cmd(os.getenv("HOME") .. "/git/lsp/PowerShellEditorServices/bin"),
  filetypes = { "ps1", "powershell" },
  root_markers = {
    "PSScriptAnalyzerSettings.psd1",
    "*.psm1",
    "*.psd1",
    ".git",
    ".svn",
  },
}

local cmd = "bash-language-server"
if not vim.fn.executable(cmd) then
  return {}
end

---@type vim.lsp.Config
return {
  cmd = { cmd, "start" },
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)",
      shfmt = {
        binaryNextLine = true,
        caseIndent = true,
        funcNextLine = false,
      },
    },
  },
  filetypes = {
    "bash",
    "sh",
    "zsh",
  },
  root_markers = {
    ".git",
    ".svn",
  },
}

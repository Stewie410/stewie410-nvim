local cmd = "diagnostic-languageserver"
if not vim.fn.executable(cmd) then
  return {}
end

---@type vim.lsp.Config
return {
  cmd = { cmd, "--stdio" },
  filetypes = {},
  root_markers = {
    ".git",
    ".svn",
  },
}

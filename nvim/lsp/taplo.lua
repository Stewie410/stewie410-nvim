local cmd = "taplo"
if not vim.fn.executable(cmd) then
  return {}
end

---@type vim.lsp.Config
return {
  cmd = { cmd, "lsp", "stdio" },
  filetypes = { "toml" },
  root_markers = {
    ".git",
    ".svn",
  },
}

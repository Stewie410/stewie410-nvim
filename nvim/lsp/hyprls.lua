local cmd = "hyprls"
if not vim.fn.executable(cmd) then
  return {}
end

---@type vim.lsp.Config
return {
  cmd = { cmd, "--stdio" },
  filetypes = { "hyprlang" },
  root_markers = {
    ".git",
    ".svn",
  },
}

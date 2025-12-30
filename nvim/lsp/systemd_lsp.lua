local cmd = "systemd-lsp"
if not vim.fn.executable(cmd) then
  return {}
end

---@type vim.lsp.Config
return {
  cmd = { cmd },
  filetypes = { "systemd" },
}

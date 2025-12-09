local cmd = "docker-langserver"
if not vim.fn.executable(cmd) then
  return {}
end

---@type vim.lsp.Config
return {
  cmd = { cmd, "--stdio" },
  filetypes = { "dockerfile" },
  root_markers = { "Dockerfile" },
}

local cmd = "docker-compose-langserver"
if not vim.fn.executable(cmd) then
  return {}
end

---@type vim.lsp.Config
return {
  cmd = { cmd, "--stdio" },
  filetypes = { "yaml.docker-compose" },
  root_markers = {
    "docker-compose.yml",
    "docker-compose.yaml",
    "compose.yml",
    "compose.yaml",
  },
}

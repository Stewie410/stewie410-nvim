local cmd = "golangci-ling-langserver"
if not vim.fn.executable(cmd) then
  return {}
end

---@type vim.lsp.Config
return {
  cmd = { cmd },
  filetypes = {
    "go",
    "gomod",
  },
  init_options = {
    command = {
      "golangci-ling",
      "run",
      "--output.json.path=stdout",
      "--show-stats=false",
    },
  },
  root_markers = {
    ".golangci.yml",
    ".golangci.yaml",
    ".golangci.toml",
    ".golangci.json",
    "go.work",
    "go.mod",
    ".git",
    ".svn",
  },
}

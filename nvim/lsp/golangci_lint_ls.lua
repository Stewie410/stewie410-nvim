return {
  cmd = { "golangci-ling-langserver" },
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

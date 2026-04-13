local cmd = "yaml-language-server"
if not vim.fn.executable(cmd) then
  return {}
end

vim.pack.add({ "https://github.com/b0o/SchemaStore.nvim" })

---@type vim.lsp.Config
return {
  cmd = { cmd, "--stdio" },
  filetypes = {
    "yaml",
    "yaml.docker-compose",
    "yaml.gitlab",
  },
  root_markers = {
    ".github",
    ".git",
    ".svn",
  },
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
}

local cmd = "vscode-json-language-server"
if not vim.fn.executable(cmd) then
  return {}
end

vim.pack.add({ "https://github.com/b0o/SchemaStore.nvim" })

---@type vim.lsp.Config
return {
  cmd = { cmd, "--stdio" },
  filetypes = { "json", "jsonc" },
  init_options = { provideFormatter = true },
  root_markers = { ".git", ".svn" },
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}

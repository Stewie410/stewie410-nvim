local cmd = "lua-language-server"
if not vim.fn.executable(cmd) then
  return {}
end

---@type vim.lsp.Config
return {
  cmd = { cmd },
  capabilities = require("util.lsp.capabilities").with_blink({
    textDocument = {
      semanticTokensProvider = nil,
    },
  }),
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
    ".svn",
  },
  settings = {
    Lua = {
      completion = {
        callSnippet = "Disable",
        keywordSnippet = "Disable",
      },
    },
  },
}

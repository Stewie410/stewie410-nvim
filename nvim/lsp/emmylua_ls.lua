---@module "util.lsp.capabilities"

return {
  cmd = { "emmylua_ls" },
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
    ".emmyrc.json",
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
  workspace_required = false,
}

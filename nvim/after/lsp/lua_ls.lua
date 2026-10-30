---@module "lspconfig"

---@type vim.lsp.Config
return {
	---@type lspconfig.settings.lua_ls
	settings = {
		Lua = {
			completion = {
				callSnippet = "Disable",
				keywordSnippet = "Disable",
			},
			hint = {
				enable = true,
			},
		},
	},
}

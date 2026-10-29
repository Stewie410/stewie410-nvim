---@module "lspconfig"

---@type vim.lsp.Config
return {
	---@type lspconfig.settings.emmylua_ls
	settings = {
		Lua = {
			completion = {
				callSnippet = "Disable",
				keywordSnippet = "Disable",
			},
		},
	},
}

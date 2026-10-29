---@module "lspconfig"

vim.pack.add({ "https://github.com/b0o/SchemaStore.nvim" })

---@type vim.lsp.Config
return {
	---@type lspconfig.settings.jsonls
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = {
				enable = true,
			},
		},
	},
}

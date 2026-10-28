vim.pack.add({ "https://github.com/b0o/SchemaStore.nvim" })

---@type vim.lsp.Config
return {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = {
				enable = true,
			},
		},
	},
}

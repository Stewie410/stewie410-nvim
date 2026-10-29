---@module "lsp.settings.texlab"

---@type vim.lsp.Config
return {
	---@type lsp.settings.texlab
	settings = {
		texlab = {
			rootDirectory = nil,
			build = {
				executable = "latexmk",
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				onSave = false,
				forwardSearchAfter = false,
			},
			forwardSearch = {
				executable = nil,
				args = {},
			},
			chktex = {
				onOpenAndSave = false,
				onEdit = false,
			},
			diagnosticsDelay = 300,
			latexFormatter = "latexindent",
			latexindent = {
				["local"] = nil,
				modifyLineBreaks = false,
			},
			bibtexFormatter = "texlab",
			formatterLineLength = 80,
		},
	},
}

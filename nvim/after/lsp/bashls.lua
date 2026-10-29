---@module "lspconfig"

---@type vim.lsp.Config
return {
	---@type lspconfig.settings.bashls
	settings = {
		bashIde = {
			shellcheckArguments = table.concat({
				-- "--check-sourced",
				-- "--color=never",
				"--norc",
			}, " "),
			shfmt = {
				binaryNextLine = true,
				caseIndent = true,
				funcNextLine = true,
				spaceRedirects = true,
			},
		},
	},
}

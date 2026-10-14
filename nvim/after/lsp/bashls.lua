---@type vim.lsp.Config
return {
	settings = {
		bashIde = {
			shellcheckArguments = {
				-- "--check-sourced",
				-- "--color=never",
				"--norc",
			},
			shfmt = {
				binaryNextLine = true,
				caseIndent = true,
				funcNextLine = true,
				spaceRedirects = true,
			},
		},
	},
}

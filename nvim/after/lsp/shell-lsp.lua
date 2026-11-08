---@module "lsp.settings.shell-lsp"

---@type vim.lsp.Config
return {
	---@type lsp.settings.shell_lsp
	settings = {
		shellLsp = {
			format = {
				binaryNextLine = true,
				spaceRedirects = true,
			},
		},
	}
}

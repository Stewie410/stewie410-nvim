---@module "lsp.settings.shuck"

---@type vim.lsp.Config
return {
	root_markers = {
		".shuck.toml",
		".shellcheckrc",
	},
	---@type lsp.settings.shuck
	settings = {
		shuck = {
			format = {
				["binary-next-line"] = true,
				["keep-padding"] = true,
				["space-redirects"] = true,
			},
		},
	},
}

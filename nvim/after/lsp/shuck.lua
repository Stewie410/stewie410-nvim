---@type vim.lsp.Config
return {
	root_markers = {
		".shuck.toml",
		".shellcheckrc",
	},
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

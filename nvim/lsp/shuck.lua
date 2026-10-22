-- https://github.com/ewhauser/shuck
local cmd = "shuck"
if not vim.fn.executable(cmd) then
	return {}
end

---@type vim.lsp.Config
return {
	cmd = { cmd, "server" },
	filetypes = {
		"bash",
		"sh",
		"zsh",
	},
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

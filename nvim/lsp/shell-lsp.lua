-- https://github.com/stubbedev/shell-lsp
local cmd = "shell-lsp"
if not vim.fn.executable(cmd) then
	return {}
end

---@type vim.lsp.Config
return {
	cmd = { cmd },
	filetypes = {
		"bash",
		"sh",
		"zsh",
		"ksh",
	},
	root_markers = {
		".git",
		".svn",
		".shellcheckrc",
	},
}

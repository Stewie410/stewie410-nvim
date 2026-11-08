local function copy(lines)
	vim.system({ "win32yank", "-i", "--crlf" }, { stdin = lines }):wait()
end

local function paste()
	local result = vim.system({ "win32yank", "-o", "--lf" }, { text = true }):wait()
	return result.code == 0 and vim.split(result.stdout:gsub("\n\n$", "\n"), "\n") or 0
end

---@type util.clipboard.Tool
return {
	name = "win32yank",
	detect = function()
		return vim.fn.executable("win32yank") == 1
	end,
	copy = {
		system = copy,
		primary = copy,
	},
	paste = {
		system = paste,
		primary = paste,
	},
}

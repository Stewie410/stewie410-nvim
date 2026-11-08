local copy = function(lines)
	vim.system({ "pbcopy" }, { stdin = lines }):wait()
end

local paste = function()
	local result = vim.system({ "pbpaste" }, { text = true }):wait()
	return result.code == 0 and vim.split(result.stdout, "\n") or 0
end

---@type util.clipboard.Tool
return {
	name = "pbcopy",
	detect = function()
		return vim.fn.executable("pbcopy") == 1
				and vim.fn.executable("pbpaste") == 1
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

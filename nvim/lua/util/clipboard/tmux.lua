local function copy(lines)
	vim.system({ "tmux", "load-buffer", "-" }, { stdin = lines }):wait()
end

local function paste()
	local result = vim.system({ "tmux", "save-buffer", "-" }, { text = true }):wait()
	return result.code == 0 and vim.split(result.stdout:gsub("\n\n$", "\n"), "\n") or 0
end

---@type util.clipboard.Tool
return {
	name = "tmux",
	detect = function()
		return vim.env.TMUX ~= nil
				and #vim.env.TMUX > 0
				and vim.fn.executable("tmux") == 1
	end,
	copy = {
		system = copy,
		primary = copy,
	},
	paste = {
		system = paste,
		primary = paste
	},
}

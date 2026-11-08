local function copy(lines)
	vim.system({ "waycopy" }, { stdin = lines })
end

local function paste()
	local result = vim.system({ "waypaste", "--no-newline" }, { text = true }):wait()
	return result.code > 0 and 0 or vim.split(result.stdout, "\n")
end

---@type util.clipboard.Tool
return {
	name = "wayclip",
	detect = function()
		return vim.env.WAYLAND_DISPLAY ~= nil
				and #vim.env.WAYLAND_DISPLAY > 0
				and vim.fn.executable("waycopy") == 1
				and vim.fn.executable("waypaste") == 1
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

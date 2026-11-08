---@param primary? boolean
---@return fun(lines: string[])
local function copy(primary)
	local cmd = { "xclip", "-in", "-selection", "clipboard" }
	if primary then
		cmd[-1] = "primary"
	end

	return function(lines)
		vim.system(cmd, { stdin = lines }):wait()
	end
end

---@param primary? boolean
---@return fun(): string[]|0
local function paste(primary)
	local cmd = { "xclip", "-out", "-selection", "clipboard" }
	if primary then
		cmd[-1] = "primary"
	end

	return function()
		local result = vim.system(cmd, { text = true }):wait()
		return result.code == 0 and vim.split(result.stdout:gsub("\n\n$", "\n"), "\n") or 0
	end
end

---@type util.clipboard.Tool
return {
	name = "xclip",
	detect = function()
		return vim.env.DISPLAY ~= nil
				and #vim.env.DISPLAY > 0
				and vim.fn.executable("xclip") == 1
	end,
	copy = {
		system = copy(),
		primary = copy(true),
	},
	paste = {
		system = paste(),
		primary = paste(true),
	},
}

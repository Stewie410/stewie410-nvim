---@param primary? boolean use primary register
---@return fun(lines: string[])
local function copy(primary)
	local cmd = { "wl-copy", "--foreground", "--type", "text/plain" }
	if primary then
		vim.list_extend(cmd, { "--primary" })
	end

	return function(lines)
		vim.system(cmd, { stdin = lines })
	end
end

---@param primary? boolean use primary register
---@return fun(): string[]|0
local function paste(primary)
	local cmd = { "wl-paste", "--no-newline" }
	if primary then
		vim.list_extend(cmd, { "--primary" })
	end

	return function()
		local result = vim.system(cmd, { text = true }):wait()
		return result.code == 0 and vim.split(result.stdout, "\n") or 0
	end
end

---@type util.clipboard.Tool
return {
	name = "wl-clipboard",
	detect = function()
		return vim.env.WAYLAND_DISPLAY ~= nil
				and #vim.env.WAYLAND_DISPLAY > 0
				and vim.fn.executable("wl-copy") == 1
				and vim.fn.executable("wl-paste") == 1
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

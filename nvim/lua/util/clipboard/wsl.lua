---@param lines string[]
local function copy(lines)
	vim.system({ "clip" }, { stdin = lines }):wait()
end

---@param split? boolean
---@return string|string[]|0
local function paste(split)
	split = split ~= nil and split or true

	local pwsh = {
		"powershell",
		"-NoLogo",
		"-NoProfile",
		"-c",
		'[Console]::Out.Write((Get-Clipboard -Raw).ToString())',
	}

	local result = vim.system(pwsh, { text = true }):wait()
	return result.code == 0 and vim.split(result.stdout:gsub("\n\n$", "\n"), "\n") or 0
end

---@type util.clipboard.Tool
return {
	name = "wsl-clip",
	detect = function()
		if not vim.fn.has("wsl") then
			return false
		end

		local in_path = vim.fn.executable("clip") + vim.fn.executable("powershell") == 2
		if not in_path then
			return false
		end

		local ch = "░"
		if vim.system({ "clip" }, { stdin = "ch" }):wait().code > 0 then
			return false
		end

		local result = paste(false)
		return result ~= nil
				and #result == #ch
				and result[1] == ch
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

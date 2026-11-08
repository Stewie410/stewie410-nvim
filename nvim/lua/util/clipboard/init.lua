---@return string
local function get_platform()
	local name = vim.uv.os_uname().sysname

	if vim.fn.has("wsl") then
		name = "wsl"
	elseif vim.env.TMUX ~= nil then
		name = "tmux"
	end

	return name:lower()
end

---@param name string
---@return boolean
local function try_set(name)
	local path = table.concat({ "util", "clipboard", name })
	local ok, tool = pcall(require, path)
	if not ok then
		vim.notify(("%s: failed to require"):format(path), vim.log.levels.WARN)
		return false
	end

	if not tool.detect() then
		return false
	end

	vim.g.clipboard = {
		name = path,
		cache_enabled = 0,
		copy = {
			["*"] = tool.copy.primary,
			["+"] = tool.copy.system,
		},
		paste = {
			["*"] = tool.paste.primary,
			["+"] = tool.paste.system,
		},
	}

	return true
end

local preference = {
	darwin = {
		"pbcopy",
	},
	linux = {
		"wl_clipboard",
		"waycopy",
		"xclip",
		"xsel",
	},
	wsl = {
		"wl_clipboard",
		"wsl",
	},
	tmux = {
		"tmux",
	},
	windows = {
		"win32yank",
	},
}

local platform = get_platform()
if preference[platform] == nil then
	return
end

for _, name in ipairs(preference[platform]) do
	if try_set(name) then
		return
	end
end

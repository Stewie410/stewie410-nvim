---Require & set clipboard helper if available, true if applied
---@param tool string module name
---@return boolean
local function try_set(tool)
	local name = table.concat({ "util", "clipboard", tool })

	local ok, module = pcall(require, name)
	if not ok then
		vim.notify(("%s: failed to require clipboard module"):format(name), vim.log.levels.DEBUG)
		return false
	end

	if not module.detect() then
		return false
	end

	vim.g.clipboard = {
		name = name,
		cache_enabled = 0,
		copy = {
			["*"] = module.copy.primary,
			["+"] = module.copy.system,
		},
		paste = {
			["*"] = module.paste.primary,
			["+"] = module.paste.system,
		},
	}

	return true
end

-- get OS or environment name
local env = vim.fn.has("wsl") and "wsl"
		or vim.env.TMUX ~= nil and "tmux"
		or vim.uv.os_uname().sysname:lower()

-- clipboard utility preference, by env
-- undefined -> use autodetect
local tool_preference = {
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
	windows_nt = {
		"win32yank",
	},
}

-- try use preferred tool, if any
-- if no tool(s) defined, pray autodetect works
for _, tool in ipairs(tool_preference[env]) do
	if try_set(tool) then
		return
	end
end

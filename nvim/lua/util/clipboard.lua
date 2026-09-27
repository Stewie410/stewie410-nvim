local M = {}

local function in_path(name)
	return vim.fn.executable(name) == 1
end

local function get_platform()
	local name = string.lower(vim.uv.os_uname().sysname)

	if string.find(string.lower(vim.uv.os_uname().release), "wsl2") then
		name = "wsl"
	elseif os.getenv("TMUX") ~= nil then
		name = "tmux"
	end

	return name
end

local tools = {
	darwin = {
		{
			name = "pbcopy",
			detect = function()
				return in_path("pbcopy") and in_path("pbpaste")
			end,
			cmd = {
				copy = "pbcopy",
				paste = "pbpaste",
			},
		},
	},
	linux = {
		{
			name = "wl-clipboard",
			detect = function()
				local display = os.getenv("WAYLAND_DISPLAY")
				local rtp = os.getenv("XDG_RUNTIME_DIR")
				local socket = (display or "") .. "/" .. (rtp or "")

				return in_path("wl-copy")
						and in_path("wl-paste")
						and display ~= nil
						and vim.fn.filereadable(socket) == 1
			end,
			cmd = {
				copy = "wl-copy",
				paste = "wl-paste --no-newline",
			},
		},
		{
			name = "waycopy",
			detect = function()
				return in_path("waycopy")
						and in_path("waypaste")
						and os.getenv("WAYLAND_DISPLAY") ~= nil
			end,
			cmd = {
				copy = "waycopy",
				paste = "waypaste --no-newline",
			},
		},
		{
			name = "xclip",
			detect = function()
				return in_path("xclip")
			end,
			cmd = {
				copy = "xclip -selection clipboard",
				paste = "xclip -selection clipboard -o",
			},
		},
		{
			name = "xsel",
			detect = function()
				return in_path("xsel")
			end,
			cmd = {
				copy = "xsel --clipboard --input",
				paste = "xsel --clipboard --ouput",
			},
		},
	},
	wsl = {
		{
			name = "wsl-clip",
			detect = function()
				return in_path("clip") and in_path("powershell")
			end,
			cmd = {
				copy = "clip",
				paste =
				'powershell -NoLogo -NoProfile -c [Console]::Out.Write((Get-Clipboard -Raw).ToString().Replace("`r", ""))',
			},
		},
	},
	tmux = {
		{
			name = "tmux",
			detect = function()
				return in_path("tmux")
			end,
			cmd = {
				copy = "tmux load-buffer -",
				paste = "tmux save-buffer -",
			},
		},
	},
	["windows_nt"] = nil,
}

function M.setup()
	local platform = get_platform()
	if tools[platform] == nil then
		return
	end

	for _, tool in ipairs(tools[platform]) do
		if tool.detect() then
			vim.g.clipboard = {
				name = "util.clipboard." .. tool.name,
				cache_enabled = 0,
				copy = {
					["*"] = tool.cmd.copy,
					["+"] = tool.cmd.copy,
				},
				paste = {
					["*"] = tool.cmd.paste,
					["+"] = tool.cmd.paste,
				},
			}
			return
		end
	end

	error("util.clipboard: failed to setup!")
end

return M

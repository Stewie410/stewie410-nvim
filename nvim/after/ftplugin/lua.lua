vim.pack.add({
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/gonstoll/wezterm-types",
	{ src = "https://github.com/saghen/blink.cmp",    version = "v1" },
	{ src = "https://github.com/saghen/blink.compat", version = "main" },
	-- "https://github.com/saghen/blink.lib",
})

local opts = {
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ path = "wezterm-types",      mods = { "wezterm" } },
	},
	enabled = function(_)
		return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
	end,
}

require("lazydev").setup(opts)

if opts.enabled() then
	local blink_conf = require("config.plugin.blink")
	table.insert(blink_conf.sources.default, "lazydev")
	blink_conf.sources.providers.lazydev = {
		name = "LazyDev",
		module = "lazydev.integrations.blink",
		score_offset = 100,
	}

	require("blink.cmp").setup(blink_conf)
end

vim.opt_local.tabstop = 2
vim.opt_local.colorcolumn = "120"

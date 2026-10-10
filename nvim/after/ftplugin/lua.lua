require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ path = "wezterm-types",      mods = { "wezterm" } },
	},
	-- should drop if switching to nvim-lspconfig
	enabled = function(_)
		local buf = vim.api.nvim_get_current_buf()
		local ws = require("lazydev").find_workspace(buf)

		if ws ~= nil or vim.g.lazydev_enabled == nil then
			return true
		end

		return vim.g.lazydev_enabled
	end,
})

vim.opt_local.tabstop = 2
vim.opt_local.colorcolumn = "120"

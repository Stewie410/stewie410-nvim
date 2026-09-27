vim.pack.add({
	"https://github.com/folke/lazydev.nvim",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "lua" },
	callback = function()
		---@diagnostic disable-next-line: missing-fields
		require("lazydev").setup({
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "wezter-types",       mods = { "wezterm" } },
			},
			enabled = function(_)
				local buf = vim.api.nvim_get_current_buf()
				local ws = require("lazydev").find_workspace(buf)

				return ((not ws == nil) or (vim.g.lazydev_enabled == nil)) and true or vim.g.lazydev_enabled
			end,
		})
	end,
})

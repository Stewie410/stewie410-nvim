require("lazydev").setup({
	library = {
		{
			path = "${3rd}/luv/library",
			words = {
				"vim%.uv",
			},
		},
		{
			path = "wezterm-types",
			mods = {
				"wezterm",
			},
		},
		{
			path = "pandoc-luals-annotations",
			words = {
				"pandoc",
			},
		},
		{
			path = vim.fn.stdpath("config") .. "/lua/types/pandoc",
			words = {
				"pandoc",
			},
		},
	},
})

vim.opt_local.tabstop = 2
vim.opt_local.colorcolumn = "120"

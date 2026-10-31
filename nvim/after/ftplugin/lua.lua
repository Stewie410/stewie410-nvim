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
			path = "pandoc-types-annotations",
			mods = {
				"pandoc-types-annotations",
			},
			words = {
				"pandoc",
			},
		},
	},
})

vim.opt_local.tabstop = 2
vim.opt_local.colorcolumn = "120"

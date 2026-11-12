local colors = require("ayu.colors")

require("ayu").setup({
	mirage = false,
	terminal = true,
	overrides = {
		LspCodeLens = {
			fg = colors.lsp_inlay_hint,
			italic = true,
		},
		LspCodeLensSeparator = {
			fg = colors.guide_active,
		},
	},
})

vim.cmd.colorscheme("ayu")

vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

require("mini.ai").setup()
require("mini.align").setup()
require("mini.bracketed").setup()
require("mini.cursorword").setup()
require("mini.jump").setup()
require("mini.move").setup()
require("mini.operators").setup()
require("mini.pairs").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()
require("mini.statusline").setup()

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	hilighters = {
		fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
		hack  = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
		todo  = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
		note  = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
	},
	hex_color = hipatterns.gen_highlighter.hex_color(),
})

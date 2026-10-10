vim.api.nvim_create_autocmd({ "PackChanged" }, {
	callback = function(ev)
		local name, kind = ev.data.name, ev.data.kind
		if name == "blink.cmp" and (kind == "install" or kind == "update") then
			vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path })
		end
	end,
	desc = "Build blink.cmp",
})

vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp",    version = "v1" },
	{ src = "https://github.com/saghen/blink.compat", version = "main" },
	-- "https://github.com/saghen/blink.lib",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/mikavilpas/blink-ripgrep.nvim",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

local conf = require("config.plugin.blink")
require("blink.cmp").setup(conf)

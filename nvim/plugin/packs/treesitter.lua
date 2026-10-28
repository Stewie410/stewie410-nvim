vim.api.nvim_create_autocmd({ "PackChanged" }, {
	callback = function(ev)
		local name, kind = ev.data.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
	desc = "Auto-Update TS Parsers",
})

vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

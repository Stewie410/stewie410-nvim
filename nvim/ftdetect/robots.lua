vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*robots.txt" },
	callback = function()
		vim.opt_local.filetype = "robots"
		vim.opt_local.syntax = "robots"
	end,
	desc = "robots.txt"
})

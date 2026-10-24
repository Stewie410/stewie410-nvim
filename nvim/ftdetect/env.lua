vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = {
		"*/default/*",
	},
	callback = function()
		vim.opt_local.filetype = "env"
		vim.opt_local.syntax = "env"
	end,
	desc = "Treat /etc/default/* (and similar) like .env",
})

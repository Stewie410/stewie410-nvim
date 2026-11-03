vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	desc = "TracWiki",
	pattern = {
		"*.trac",
		"*.tracwiki",
		"*.trac.wiki",
	},
	callback = function()
		vim.bo.filetype = "tracwiki"
	end,
})

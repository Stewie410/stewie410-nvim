vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	desc = "Detect dockerfiles, regardless of bad naming practices",
	pattern = {
		"*Dockerfile",
		"Dockerfile*",
	},
	callback = function(ev)
		vim.bo.filetype = "dockerfile"
	end,
})

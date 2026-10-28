-- can probably just set this as a global option
vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Don't auto-wrap comments or insert leader on o|O",
	group = vim.api.nvim_create_augroup("comment.dx", { clear = true }),
	callback = function()
		vim.bo.formatoptions = vim.bo.formatoptions:gsub("[co]", "")
	end,
})

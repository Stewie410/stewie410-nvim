vim.api.nvim_create_autocmd({ "TermOpen" }, {
	desc = "Set filetype",
	group = vim.api.nvim_create_augroup("term.setft", { clear = true }),
	callback = function()
		vim.bo.filetype = "terminal"
	end,
})

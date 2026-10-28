vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	desc = "Trim trailing whitespace",
	group = vim.api.nvim_create_augroup("onwrite.trim", { clear = true }),
	callback = function()
		local pos = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", pos)
	end,
})

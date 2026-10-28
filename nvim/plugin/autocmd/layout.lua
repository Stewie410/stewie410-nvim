vim.api.nvim_create_autocmd({ "VimResized" }, {
	desc = "Resize splits when nvim resized",
	group = vim.api.nvim_create_augroup("layout.resized", { clear = true }),
	callback = function()
		local tab = vim.api.nvim_get_current_tabpage()
		local ch = vim.o.cmdheight

		vim.cmd.tabdo("wincmd -")
		vim.api.nvim_set_current_tabpage(tab)
		vim.o.cmdheight = ch
	end,
})

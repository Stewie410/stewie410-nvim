local ag = vim.api.nvim_create_augroup("lsp.setup", { clear = true })

vim.api.nvim_create_autocmd({ "LspAttach" }, {
	desc = "LSP Setup",
	group = ag,
	callback = function()
		vim.o.omnifunc = "v:lua.vim.lsp.omnifunc"
		vim.lsp.codelens.enable(true)
	end,
})

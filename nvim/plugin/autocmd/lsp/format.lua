local ag = vim.api.nvim_create_augroup("lsp.format", { clear = true })

vim.api.nvim_create_autocmd({ "LspAttach" }, {
	desc = "LSP Format",
	group = ag,
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end

		if client:supports_method("textDocument/willSaveWaitUntil") then
			return
		end

		if not client:supports_method("textDocument/formatting") then
			return
		end

		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			group = ag,
			buffer = ev.buf,
			callback = function()
				vim.lsp.buf.format({
					bufnr = ev.buf,
					id = client.id,
					timeout_ms = 1000,
				})
			end,
		})
	end,
})

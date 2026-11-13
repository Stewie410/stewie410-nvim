local ag = vim.api.nvim_create_augroup("lsp.highlight", { clear = true })

vim.api.nvim_create_autocmd({ "LspAttach" }, {
	desc = "LSP Highlights",
	group = ag,
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end

		if not client:supports_method("textDocument/documentHighlight") then
			return
		end

		vim.api.nvim_create_autocmd({ "CursorHold", "CursorMovedI" }, {
			group = ag,
			buffer = ev.buf,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			group = ag,
			buffer = ev.buf,
			callback = vim.lsp.buf.clear_references,
		})
	end,
})

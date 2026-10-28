-- TODO: switch to default keymap
vim.api.nvim_create_autocmd({ "LspAttach" }, {
	desc = "LSP: Custom keymaps",
	group = vim.api.nvim_create_augroup("lsp.attach.keymap", { clear = true }),
	callback = function(ev)
		local keymap = {
			["<leader>gd"] = { fn = vim.lsp.buf.definition, name = "Definition" },
			["<leader>gD"] = { fn = vim.lsp.buf.declaration, name = "Declaration" },
			["<leader>gr"] = { fn = vim.lsp.buf.references, name = "References" },
			["<leader>gi"] = { fn = vim.lsp.buf.implementation, name = "Implementation" },
			["<leader>gt"] = { fn = vim.lsp.buf.type_definition, name = "Type Definition" },
			["<leader>gs"] = { fn = vim.lsp.buf.document_symbol, name = "Document Symbol" },
			["<leader>gw"] = { fn = vim.lsp.buf.workspace_symbol, name = "Workspace Symbol" },
			["<leader>ca"] = { fn = vim.lsp.buf.code_action, name = "Code Action" },
			["<leader>rn"] = { fn = vim.lsp.buf.rename, "Rename" },
			["K"] = { fn = vim.lsp.buf.hover, name = "Hover Documentation" },
		}

		for keys, t in pairs(keymap) do
			vim.keymap.set("n", keys, t.fn, {
				buffer = ev.buf,
				silent = true,
				noremap = true,
				desc = ("LSP: %s"):format(t.name),
			})
		end
	end,
})

local ag = {
	def = vim.api.nvim_create_augroup("lsp.attach", { clear = true }),
	cmd = vim.api.nvim_create_augroup("lsp.attach.cmd", { clear = true }),
	fmt = vim.api.nvim_create_augroup("lsp.format", { clear = true }),
	hl = vim.api.nvim_create_augroup("lsp.hilight", { clear = true }),
}

local function get_client(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if client == nil then
		error(("lsp: failed to get client by id (buf[%d]): %s"):format(ev.buf, ev.data.client_id))
	end
	return client
end

-- setup
vim.api.nvim_create_autocmd({ "LspAttach" }, {
	desc = "LSP setup",
	group = ag.def,
	callback = function()
		vim.o.omnifunc = "v:lua.vim.lsp.omnifunc"
		vim.lsp.codelens.enable(true)
	end,
})

vim.api.nvim_create_autocmd({ "LspAttach" }, {
	desc = "LSP format",
	group = ag.def,
	callback = function(ev)
		local client = get_client(ev)

		if client:supports_method("textDocument/willSaveWaitUntil") then
			return
		end

		if not client:supports_method("textDocument/formatting") then
			return
		end

		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			desc = "buf-local lsp formatting",
			group = ag.fmt,
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

vim.api.nvim_create_autocmd({ "LspAttach" }, {
	desc = "LSP Highlighting",
	group = ag.hl,
	callback = function(ev)
		local client = get_client(ev)

		if not client:supports_method("textDocument/documentHighlight") then
			return
		end

		vim.api.nvim_create_autocmd({ "CursorHold", "CursorMovedI" }, {
			desc = "buf-local lsp highlights",
			group = ag.hl,
			buffer = ev.buf,
			callback = function()
				vim.lsp.buf.document_highlight()
			end,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			desc = "buf-local lsp clear refs",
			group = ag.hl,
			buffer = ev.buf,
			callback = function()
				vim.lsp.buf.clear_references()
			end,
		})
	end,
})

-- maybe we don't need this?
vim.api.nvim_create_autocmd({ "LspAttach" }, {
	desc = "Usercommands to open lsp.log in a [v]split",
	group = ag.cmd,
	once = true,
	callback = function(ev)
		vim.api.nvim_buf_create_user_command(ev.buf, "LspLog", function()
			vim.cmd.split(vim.lsp.log.get_filename())
		end, { desc = "Open lsp.log in a :split" })

		vim.api.nvim_buf_create_user_command(ev.buf, "VLspLog", function()
			vim.cmd.split(vim.lsp.log.get_filename())
		end, { desc = "Open lsp.log in a :vsplit" })
	end,
})

-- TODO: get used to checkhealth instead
vim.api.nvim_create_autocmd({ "LspAttach" }, {
	desc = "Usercommand to view attached clients",
	group = ag.cmd,
	once = true,
	callback = function(ev)
		vim.api.nvim_buf_create_user_command(ev.buf, "LspClient", function()
			local human = vim.split(vim.inspect(vim.lsp.get_clients()), "\n")
			vim.cmd.split("new")
			vim.api.nvim_buf_set_lines(vim.api.nvim_get_current_buf(), 0, -1, false, human)
			vim.notify("prefer :checkhealth vim.lsp", vim.log.levels.DEBUG)
		end, { desc = "View attached LSP clients" })
	end,
})

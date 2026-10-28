local cmd_ag = vim.api.nvim_create_augroup("lsp.attach.cmd", { clear = true })

-- setup
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group = vim.api.nvim_create_augroup("lsp.attach", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    assert(client, ("Cannot determine LSP Client in buf[%d]"):format(ev.buf))

    vim.o.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.lsp.codelens.enable(true)

    local supports = {
      cmp = client:supports_method("textDocument/completion"),
      wait = client:supports_method("textDocument/willSaveWaitUntil"),
      fmt = client:supports_method("textDocument/formatting"),
    }

    if not supports.wait and supports.fmt then
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        group = vim.api.nvim_create_augroup("lsp.format", {}),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

-- maybe we don't need this?
vim.api.nvim_create_autocmd({ "LspAttach" }, {
	desc = "Usercommands to open lsp.log in a [v]split",
	group = cmd_ag,
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
	group = cmd_ag,
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

local ag = vim.api.nvim_create_augroup("lsp.command", { clear = true })

vim.api.nvim_create_autocmd({ "LspAttach" }, {
	desc = "Usercommands to open lsp.log in a split",
	group = ag,
	once = true,
	callback = function(ev)
		if not vim.lsp.get_client_by_id(ev.data.client) then
			return
		end

		vim.api.nvim_buf_create_user_command(ev.buf, "LspLog", function()
			vim.cmd.split(vim.lsp.log.get_filename())
		end, { desc = "Open lsp.log in a :split" })

		vim.api.nvim_buf_create_user_command(ev.buf, "VLspLog", function()
			vim.cmd.vsplit(vim.lsp.log.get_filename())
		end, { desc = "Open lsp.log in a :vsplit" })
	end
})

vim.api.nvim_create_autocmd({ "LspAttach" }, {
	desc = "Usercommands to inspect attached clients in a split",
	group = ag,
	once = true,
	callback = function(ev)
		if not vim.lsp.get_client_by_id(ev.data.client) then
			return
		end

		---@param vsplit boolean
		local function to_split(vsplit)
			local text = vim.split(vim.inspect(vim.lsp.get_clients()), "\n")
			vim.cmd(("%ssplit lsp_clients"):format(vsplit and "v" or ""))
			vim.api.nvim_buf_set_lines(vim.api.nvim_get_current_buf(), 0, -1, false, text)
			vim.notify("prefer :checkhealth vim.lsp", vim.log.levels.WARN)
		end

		vim.api.nvim_buf_create_user_command(ev.buf, "LspClient", function()
			to_split(false)
		end, { desc = "View attached LSP clients in a :split" })

		vim.api.nvim_buf_create_user_command(ev.buf, "VLspClient", function()
			to_split(true)
		end, { desc = "View attached LSP clients in a :split" })
	end,
})

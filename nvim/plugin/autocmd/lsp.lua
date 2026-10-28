local cmd_ag = vim.api.nvim_create_augroup("lsp.attach.cmd", { clear = true })

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

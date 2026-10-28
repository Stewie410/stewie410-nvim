vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
	desc = "q & <Esc> always quits",
	group = vim.api.nvim_create_augroup("escape.quit", { clear = true }),
	pattern = {
		"help",
		"startuptime",
		"qf",
		"lspinfo",
		"man",
		"checkhealth",
		"neotest-output-panel",
		"neotest-summary",
		"lazy",
		"mason",
	},
	callback = function()
		local opts = {
			silent = true,
			buffer = true,
			desc = "Quit",
		}

		vim.keymap.set("n", "q", ":close<CR>", opts)
		vim.keymap.set("n", "<Esc>", ":close<CR>", opts)
	end,
})

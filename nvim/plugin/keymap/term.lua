vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Quick Escape" })

vim.keymap.set("n", "<leader>ot", function()
	vim.cmd.new()
	vim.cmd.term()
	vim.cmd.startinsert()
end, { desc = "Open Terminal" })

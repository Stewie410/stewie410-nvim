vim.keymap.set("n", "<leader>pu", vim.pack.update, { desc = "Plugin Update" })

vim.keymap.set("n", "<leader>pU", function()
	vim.pack.update(nil, {
		target = "lockfile",
		force = true,
	})
end, { desc = "Plugin Update: Pinned to Lockfile" })

vim.keymap.set("n", "<leader>pi", function()
	vim.pack.update(nil, {
		offline = true,
	})
end, { desc = "Plugin Info" })

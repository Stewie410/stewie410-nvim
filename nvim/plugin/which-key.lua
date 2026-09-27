vim.pack.add({
	"https://github.com/folke/which-key.nvim",
})

local which = require("which-key")
---@diagnostic disable-next-line: missing-fields
which.setup({
	preset = "helix",
	spec = {
		{ "<leader>c", group = "[C]ode" },
		{ "<leader>d", group = "[D]ocument" },
		{ "<leader>f", group = "[F]ind" },
		{ "<leader>r", group = "[R]ename" },
		{ "<leader>s", group = "[S]urround" },
		{ "<leader>w", group = "[W]orkspace" },
		{ "<leader>t", group = "[T]oggle" },
	}
})

vim.keymap.set("n", "<leader>?", function() which.show({ global = false }) end, { desc = "Buffer Keymaps" })

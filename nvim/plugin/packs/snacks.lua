vim.pack.add({
	"https://github.com/folke/snacks.nvim",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

require("snacks").setup({
	bigfile = { enabled = true },
	explorer = { enabled = true },
	git = { enabled = true },
	indent = {
		enabled = true,
		animate = { enabled = false },
		scope = { enabled = true },
	},
	input = { enabled = true },
	notifier = {
		enabled = true,
		timeout = 3000,
	},
	picker = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	words = { enabled = true },
})

vim.api.nvim_create_autocmd({ "User" }, {
	callback = function()
		Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>uc")
		Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
		Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
		Snacks.toggle.diagnostics():map("<leader>ud")
		Snacks.toggle.line_number():map("<leader>ul")
		Snacks.toggle.option(
			"conceallevel",
			{ off = "light", on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
		):map("<leader>uC")
		Snacks.toggle.treesitter():map("<leader>uT")
		Snacks.toggle.option(
			"background",
			{ off = "light", on = "dark", name = "Dark Background" }
		):map("<leader>ub")
		Snacks.toggle.inlay_hints():map("<leader>uh")
		Snacks.toggle.indent():map("<leader>ug")
		Snacks.toggle.dim():map("<leader>uD")
	end,
	desc = "snacks.nvim init"
})

vim.keymap.set("n", "<C-b>", function() Snacks.explorer() end, { desc = "Explorer" })
vim.keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep Buffers" })
vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "[N]otifications" })
vim.keymap.set("n", "<leader>d", function() Snacks.picker.diagnostics() end, { desc = "[D]iagnostics" })
vim.keymap.set("n", "<leader>D", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer [D]iagnostics" })
vim.keymap.set("n", "<leader>q", function() Snacks.picker.qflist() end, { desc = "[Q]uickfix List" })
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "[F]ind [F]iles" })

-- vim.key.amp.set("n", "<leader>gf", function() Snacks.picker.git_files() end, { desc = "[G]it [F]iles" })
-- vim.key.amp.set("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "[G]it [B]ranches" })
-- vim.key.amp.set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "[G]it [L]og" })
-- vim.key.amp.set("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "[G]it log [L]ine" })
-- vim.key.amp.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "[G]it [S]tatus" })
-- vim.key.amp.set("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "[G]it [S]tash" })
-- vim.key.amp.set("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "[G]it [D]iff" })
-- vim.key.amp.set("n", "<leader>gB", function() Snacks.gitbrowse() end, { desc = "[G]it [B]rowse" })

-- vim.keymap.set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "[S]earch [B]uffer" })
-- vim.keymap.set({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "[S]earch [W]ords" })
-- vim.keymap.set("n", "<leader>sr", function() Snacks.picker.registers() end, { desc = "[S]earch [R]egisters" })
-- vim.keymap.set("n", "<leader>sh", function() Snacks.picker.search_history() end, { desc = "[S]earch [H]istory" })
-- vim.keymap.set("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "[S]earch [A]utocmds" })
vim.keymap.set("n", "<leader>sc", function() Snacks.picker.commands() end, { desc = "[S]each [C]ommands" })
vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "[S]earch [H]elp" })
-- vim.keymap.set("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "[S]earch [H]ighlights" })
vim.keymap.set("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "[S]earch [I]cons" })
vim.keymap.set("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "[S]each [J]umps" })
vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "[S]earch [K]eymaps" })
-- vim.keymap.set("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "[S]each [L]ocation List" })
vim.keymap.set("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "[S]earch [M]arks" })
-- vim.keymap.set("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "[S]earch [M]anpages" })
-- vim.keymap.set("n", "<leader>sp", function() Snacks.picker.lazy() end, { desc = "[S]each [P]lugins" })
-- vim.keymap.set("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "[S]earch [U]ndo" })

vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "[F]ind [B]uffers" })
-- vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "[F]ind [P]rojects" })
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "[F]ind [R]ecent" })

vim.keymap.set("n", "<leader>rf", function() Snacks.rename.rename_file() end, { desc = "[R]ename [F]ile" })
vim.keymap.set("n", "<leader>dn", function() Snacks.notifier.hide() end, { desc = "[D]ismiss [N]otifier" })
-- vim.keymap.set({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Reference: Prev" } })
-- vim.keymap.set({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Reference: Next" })

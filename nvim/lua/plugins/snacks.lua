vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = true },
  git = { enabled = true },
  indent = {
    enabled = true,
    animate = { enabled = false },
    scope = { enabled = false },
  },
  input = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  picker = { enabled = true },
  quickfile = { enabled = true },
  statuscolumn = { enabled = false },
  scope = { enabled = true },
  words = { enabled = true },
})

if not vim.g.vim_pack_init.snacks then
  vim.api.nvim_create_autocmd({ "User" }, {
    desc = "snacks.nvim init",
    callback = function()
      ---@diagnostic disable: duplicate-set-field
      _G.dd = function(...)
        Snacks.debug.inspect(...)
      end

      ---@diagnostic disable: duplicate-set-field
      _G.bt = function()
        Snacks.debug.backtrace()
      end

      vim.print = _G.dd

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
  })

  vim.g.vim_pack_init.snacks = 1
end

local map = vim.keymap.set
map("n", "<C-b>", function() Snacks.explorer() end, { desc = "Explorer" })
map("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
map("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep Buffers" })
map("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
map("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "[N]otifications" })
map("n", "<leader>d", function() Snacks.picker.diagnostics() end, { desc = "[D]iagnostics" })
map("n", "<leader>D", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer [D]iagnostics" })
map("n", "<leader>q", function() Snacks.picker.qflist() end, { desc = "[Q]uickfix List" })
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "[F]ind [F]iles" })

-- map("n", "<leader>gf", function() Snacks.picker.git_files() end, { desc = "[G]it [F]iles" })
-- map("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "[G]it [B]ranches" })
-- map("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "[G]it [L]og" })
-- map("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "[G]it log [L]ine" })
-- map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "[G]it [S]tatus" })
-- map("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "[G]it [S]tash" })
-- map("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "[G]it [D]iff" })
-- map("n", "<leader>gB", function() Snacks.gitbrowse() end, { desc = "[G]it [B]rowse" })

-- map("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "[S]earch [B]uffer" })
-- map("n", "<leader>sw", function() Snacks.picker.grep_word() end, desc = "[S]earch [W]ords", { mode = { "n", "x" } })
-- map("n", "<leader>sr", function() Snacks.picker.registers() end, { desc = "[S]earch [R]egisters" })
-- map("n", "<leader>sh", function() Snacks.picker.search_history() end, { desc = "[S]earch [H]istory" })
-- map("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "[S]earch [A]utocmds" })
map("n", "<leader>sc", function() Snacks.picker.commands() end, { desc = "[S]each [C]ommands" })
map("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "[S]earch [H]elp" })
-- map("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "[S]earch [H]ighlights" })
map("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "[S]earch [I]cons" })
map("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "[S]each [J]umps" })
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "[S]earch [K]eymaps" })
-- map("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "[S]each [L]ocation List" })
map("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "[S]earch [M]arks" })
-- map("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "[S]earch [M]anpages" })
-- map("n", "<leader>sp", function() Snacks.picker.lazy() end, { desc = "[S]each [P]lugins" })
-- map("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "[S]earch [R]esume" })
map("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "[S]earch [U]ndo" })

map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "[F]ind [B]uffers" })
-- map("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "[F]ind [P]rojects" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "[F]ind [R]ecent" })

map("n", "<leader>rf", function() Snacks.rename.rename_file() end, { desc = "[R]ename [F]ile" })
map("n", "<leader>dn", function() Snacks.notifier.hide() end, { desc = "[D]ismiss [N]otifier" })
-- map("n", "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Reference: Prev", { mode = { "n", "t" } })
-- map("n", "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Reference: Next", { mode = { "n", "t" } })

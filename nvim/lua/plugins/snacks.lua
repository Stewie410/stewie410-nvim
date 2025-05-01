return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
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
    },
    keys = {
      { "<C-b>",           function() Snacks.explorer() end,                  desc = "Explorer" },
      { "<leader><space>", function() Snacks.picker.smart() end,              desc = "Smart Find Files" },
      { "<leader>/",       function() Snacks.picker.grep() end,               desc = "Grep" },
      { "<leader>:",       function() Snacks.picker.command_history() end,    desc = "Command History" },
      { "<leader>,",       function() Snacks.picker.buffers() end,            desc = "Buffers" },
      { "<leader>n",       function() Snacks.picker.notifications() end,      desc = "Notifications" },
      { "<leader>d",       function() Snacks.picker.diagnostics() end,        desc = "Diagnostics" },
      { "<leader>D",       function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>q",       function() Snacks.picker.qflist() end,             desc = "Quickfix List" },

      { "<leader>ff",      function() Snacks.picker.files() end,              desc = "[F]ind [F]iles" },

      -- { "<leader>gf", function() Snacks.picker.git_files() end, desc = "[G]it [F]iles" },
      -- { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "[G]it [B]ranches" },
      -- { "<leader>gl", function() Snacks.picker.git_log() end, desc = "[G]it [L]og" },
      -- { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "[G]it log [L]ine" },
      -- { "<leader>gs", function() Snacks.picker.git_status() end, desc = "[G]it [S]tatus" },
      -- { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "[G]it [S]tash" },
      -- { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "[G]it [D]iff" },
      -- { "<leader>gB", function() Snacks.gitbrowse() end, desc = "[G]it [B]rowse" },

      -- { "<leader>sb", function() Snacks.picker.lines() end, desc = "[S]earch [B]uffer" },
      -- { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "[S]earch [W]ords", mode = { "n", "x" } },
      -- { "<leader>sr", function() Snacks.picker.registers() end, desc = "[S]earch [R]egisters" },
      -- { "<leader>sh", function() Snacks.picker.search_history() end, desc = "[S]earch [H]istory" },
      -- { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "[S]earch [A]utocmds" },
      { "<leader>sc",      function() Snacks.picker.commands() end,           desc = "[S]each [C]ommands" },
      { "<leader>sh",      function() Snacks.picker.help() end,               desc = "[S]earch [H]elp" },
      -- { "<leader>sH", function() Snacks.picker.highlights() end, desc = "[S]earch [H]ighlights" },
      { "<leader>si",      function() Snacks.picker.icons() end,              desc = "[S]earch [I]cons" },
      { "<leader>sj",      function() Snacks.picker.jumps() end,              desc = "[S]each [J]umps" },
      { "<leader>sk",      function() Snacks.picker.keymaps() end,            desc = "[S]earch [K]eymaps" },
      -- { "<leader>sl", function() Snacks.picker.loclist() end, desc = "[S]each [L]ocation List" },
      { "<leader>sm",      function() Snacks.picker.marks() end,              desc = "[S]earch [M]arks" },
      -- { "<leader>sM", function() Snacks.picker.man() end, desc = "[S]earch [M]anpages" },
      -- { "<leader>sp", function() Snacks.picker.lazy() end, desc = "[S]each [P]lugins" },
      -- { "<leader>sR", function() Snacks.picker.resume() end, desc = "[S]earch [R]esume" },
      { "<leader>su",      function() Snacks.picker.undo() end,               desc = "[S]earch [U]ndo" },

      { "<leader>fb",      function() Snacks.picker.buffers() end,            desc = "[F]ind [B]uffers" },
      -- { "<leader>fp", function() Snacks.picker.projects() end, desc = "[F]ind [P]rojects" },
      { "<leader>fr",      function() Snacks.picker.recent() end,             desc = "[F]ind [R]ecent" },

      { "<leader>rf",      function() Snacks.rename.rename_file() end,        desc = "[R]ename [F]ile" },
      { "<leader>dn",      function() Snacks.notifier.hide() end,             desc = "[D]ismiss [N]otifier" },
      -- { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Reference: Prev", mode = { "n", "t" } },
      -- { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Reference: Next", mode = { "n", "t" } },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
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
    end,
  },
}

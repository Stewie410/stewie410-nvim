return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      explorer = { enabled = true },
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
      scope = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      -- top pickers & explorer
      {
        "<leader><space>",
        function()
          require("snacks").picker.smart()
        end,
        desc = "[S]mart [F]ind [F]iles",
      },
      {
        "<leader>/",
        function()
          require("snacks").picker.grep()
        end,
        desc = "Grep files",
      },
      {
        "<leader>:",
        function()
          require("snacks").picker.command_history()
        end,
        desc = "Find Command History",
      },
      {
        "<C-b>",
        function()
          require("snacks").explorer()
        end,
        desc = "File Explorer",
      },

      -- find xyz
      {
        "<leader>fb",
        function()
          require("snacks").picker.buffers()
        end,
        desc = "[F]ind [B]uffers",
      },
      {
        "<leader>ff",
        function()
          require("snacks").picker.files()
        end,
        desc = "[F]ind [F]iles",
      },
      {
        "<leader>fg",
        function()
          require("snacks").picker.git_files()
        end,
        desc = "[F]ind [G]it Files",
      },
      {
        "<leader>fp",
        function()
          require("snacks").picker.projects()
        end,
        desc = "[F]ind [P]rojects",
      },
      {
        "<leader>fr",
        function()
          require("snacks").picker.recent()
        end,
        desc = "[F]ind [R]ecent",
      },

      -- git
      {
        "<leader>gb",
        function()
          require("snacks").picker.git_branches()
        end,
        desc = "[G]it [B]ranches",
      },
      {
        "<leader>gl",
        function()
          require("snacks").picker.git_log()
        end,
        desc = "[G]it [L]og",
      },
      {
        "<leader>gL",
        function()
          require("snacks").picker.git_log_line()
        end,
        desc = "[G]it Log [L]ine",
      },
      {
        "<leader>gs",
        function()
          require("snacks").picker.git_status()
        end,
        desc = "[G]it [S]tatus",
      },
      {
        "<leader>gS",
        function()
          require("snacks").picker.git_stash()
        end,
        desc = "[G]it [S]tash",
      },
      {
        "<leader>gd",
        function()
          require("snacks").picker.git_diff()
        end,
        desc = "[G]it [D]iff",
      },

      -- grep
      {
        "<leader>sb",
        function()
          require("snacks").picker.lines()
        end,
        desc = "[S]earch [B]uffer Lines",
      },
      {
        "<leader>sB",
        function()
          require("snacks").picker.grep_buffers()
        end,
        desc = "[S]earch Open [B]uffers",
      },
      {
        "<leader>sg",
        function()
          require("snacks").picker.grep()
        end,
        desc = "[S]earch [G]rep",
      },
      {
        "<leader>sw",
        function()
          require("snacks").picker.grep_word()
        end,
        desc = "Visual selection or word",
        mode = { "n", "x" },
      },

      -- search
      {
        "<leader>sr",
        function()
          require("snacks").picker.registers()
        end,
        desc = "[S]earch [R]egisters",
      },
      {
        "<leader>sh",
        function()
          require("snacks").picker.search_history()
        end,
        desc = "[S]earch [H]istory",
      },
      {
        "<leader>sa",
        function()
          require("snacks").picker.autocmds()
        end,
        desc = "[S]earch [A]utocmds",
      },
      {
        "<leader>sc",
        function()
          require("snacks").picker.command_history()
        end,
        desc = "[S]earch [C]ommand History",
      },
      {
        "<leader>sC",
        function()
          require("snacks").picker.commands()
        end,
        desc = "[S]earch [C]ommands",
      },
      {
        "<leader>sd",
        function()
          require("snacks").picker.diagnostics()
        end,
        desc = "[S]earch [D]iagnostics",
      },
      {
        "<leader>sD",
        function()
          require("snacks").picker.diagnostics_buffer()
        end,
        desc = "[S]earch Buffer [D]iagnostics",
      },
      {
        "<leader>sh",
        function()
          require("snacks").picker.help()
        end,
        desc = "[S]earch [H]elp",
      },
      {
        "<leader>sH",
        function()
          require("snacks").picker.highlights()
        end,
        desc = "[S]earch [H]ighlights",
      },
      {
        "<leader>si",
        function()
          require("snacks").picker.icons()
        end,
        desc = "[S]earch [I]cons",
      },
      {
        "<leader>sj",
        function()
          require("snacks").picker.jumps()
        end,
        desc = "[S]earch [J]umps",
      },
      {
        "<leader>sk",
        function()
          require("snacks").picker.keymaps()
        end,
        desc = "[S]earch [K]eymaps",
      },
      {
        "<leader>sl",
        function()
          require("snacks").picker.loclist()
        end,
        desc = "[S]earch [L]ocation List",
      },
      {
        "<leader>sm",
        function()
          require("snacks").picker.marks()
        end,
        desc = "[S]earch [M]arks",
      },
      {
        "<leader>sM",
        function()
          require("snacks").picker.man()
        end,
        desc = "[S]earch [M]anpages",
      },
      {
        "<leader>sp",
        function()
          require("snacks").picker.lazy()
        end,
        desc = "[S]earch [P]lugin Spec",
      },
      {
        "<leader>sq",
        function()
          require("snacks").picker.qflist()
        end,
        desc = "[S]each [Q]uickfix List",
      },
      {
        "<leader>sR",
        function()
          require("snacks").picker.resume()
        end,
        desc = "[S]earch [R]esume",
      },
      {
        "<leader>su",
        function()
          require("snacks").picker.undo()
        end,
        desc = "[S]earch [U]ndo History",
      },

      -- LSP
      {
        "gd",
        function()
          require("snacks").picker.lsp_definitions()
        end,
        desc = "[G]oto [D]efinition",
      },
      {
        "gD",
        function()
          require("snacks").picker.lsp_declarations()
        end,
        desc = "[G]oto [D]eclaration",
      },
      {
        "gr",
        function()
          require("snacks").picker.lsp_references()
        end,
        nowait = true,
        desc = "[G]oto [R]eferences",
      },
      {
        "gI",
        function()
          require("snacks").picker.lsp_implementations()
        end,
        desc = "[G]oto [I]mplementation",
      },
      {
        "gy",
        function()
          require("snacks").picker.lsp_type_definitions()
        end,
        desc = "[G]oto T[y]pe Definition",
      },
      {
        "<leader>ss",
        function()
          require("snacks").picker.lsp_symbols()
        end,
        desc = "[S]earch [S]ymbols",
      },
      {
        "<leader>sS",
        function()
          require("snacks").picker.lsp_workspace_symbols()
        end,
        desc = "[S]earch LSP Workspace [S]ymbols",
      },

      -- other
      {
        "<leader>cR",
        function()
          require("snacks").rename.rename_file()
        end,
        desc = "[R]ename File",
      },
      {
        "<leader>gB",
        function()
          require("snacks").gitbrowse()
        end,
        desc = "[G]it [B]rowse",
      },
      {
        "<leader>nh",
        function()
          require("snacks").notifier.show_history()
        end,
        desc = "[N]otification [H]istory",
      },
      {
        "<leader>un",
        function()
          require("snacks").notifier.hide()
        end,
        desc = "Dismiss [N]otifications",
      },
      {
        "[[",
        function()
          require("snacks").words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
        mode = { "n", "t" },
      },
      {
        "]]",
        function()
          require("snacks").words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
        mode = { "n", "t" },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          local Snacks = require("snacks")

          -- debug globals
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end

          -- override print for ':=' command
          vim.print = _G.dd

          -- toggle mappings
          -- Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>st")
          -- Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>wt")
          -- Snacks.toggle.diagnostics():map("<leader>dt")
          -- Snacks.toggle
          --   .option("conceallevel", {
          --     off = 0,
          --     on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
          --   })
          --   :map("<leader>tcl")
          -- Snacks.toggle.treesitter():map("<leader>Tt")
          -- Snacks.toggle.inlay_hints():map("<leader>it")
        end,
      })
    end,
  },
}

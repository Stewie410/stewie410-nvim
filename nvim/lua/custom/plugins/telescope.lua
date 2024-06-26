return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("telescope").setup({
        extension = {
          fzf = {},
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      local tsb = require("telescope.builtin")
      local tst = require("telescope.themes")
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { desc = desc })
      end

      map("<leader>fh", tsb.help_tags, "[F]ind [H]elp")
      map("<leader>fk", tsb.keymaps, "[F]ind [K]eymaps")
      map("<leader>ff", tsb.find_files, "[F]ind [F]iles")
      map("<leader>fs", tsb.builtin, "[F]ind [S]elect Telescope")
      map("<leader>fw", tsb.grep_string, "[S]each [W]ord")
      map("<leader>fg", tsb.live_grep, "[F]ind with [G]rep")
      map("<leader>fd", tsb.diagnostics, "[F]ind [D]iagnostics")
      map("<leader>fr", tsb.resume, "[F]ind [R]esume")
      map("<leader>f.", tsb.oldfiles, "[F]ind Recent [F]iles")
      map("<leader>fb", tsb.buffers, "[F]ind [B]uffers")
      map(
        "<leader>f/",
        tsb.current_buffer_fuzzy_find,
        "Fuzzy [F]ind in current buffer"
      )
    end,
  },
}

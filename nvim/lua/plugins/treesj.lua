return {
  {
    "Wansmer/treesj",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>ts", function() require("treesj").split() end,  desc = "TS: Split" },
      { "<leader>tj", function() require("treesj").join() end,   desc = "TS: Join" },
      { "<leader>tt", function() require("treesj").toggle() end, desc = "TS: Split/Join" },
    },
    opts = {
      use_default_keymaps = false,
    },
  },
}

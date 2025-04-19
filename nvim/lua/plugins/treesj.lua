return {
  {
    "Wansmer/treesj",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      {
        "J",
        function()
          require("treesj").toggle()
        end,
        desc = "Split/Join code block",
      },
    },
    opts = {
      use_default_keymaps = false,
    },
  },
}

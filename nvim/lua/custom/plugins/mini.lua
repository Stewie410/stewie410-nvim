return {
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.bracketed").setup()
      require("mini.comment").setup()
      require("mini.cursorword").setup()
      require("mini.hipatterns").setup({
        highlighters = {
          hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
        },
      })
      require("mini.surround").setup()
      require("mini.pairs").setup()
      require("mini.operators").setup()
    end,
  },
}

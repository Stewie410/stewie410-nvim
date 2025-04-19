return {
  {
    "OXY2DEV/markview.nvim",
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown", "norg", "rmd", "org" },
    opts = {
      links = {
        inline_links = {
          hl = "@markup.link.label.markown_inline",
          icon = " ",
          icon_hl = "@markup.link",
        },
        images = {
          hl = "@markup.link.label.markown_inline",
          icon = " ",
          icon_hl = "@markup.link",
        },
      },
      code_blocks = {
        style = "language",
        hl = "CodeBlock",
        pad_amount = 0,
      },
      list_items = {
        shift_width = 2,
      },
    },
  },
}

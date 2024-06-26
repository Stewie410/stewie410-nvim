return {
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      theme = "auto",
      extensions = {
        "fzf",
        "lazy",
        "man",
        "mason",
        "nvim-dap-ui",
        "nvim-tree",
        "oil",
        "quickfix",
        "trouble",
      },
    },
  },
}

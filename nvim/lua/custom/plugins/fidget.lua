return {
  {
    "j-hui/fidget.nvim",
    lazy = false,
    opts = {
      progress = {
        display = {
          skip_history = false,
        },
      },
      notification = {
        override_vim_notify = false,
      },
      integration = {
        ["nvim-tree"] = { enable = true },
      },
    },
  },
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*.service",
    "*.socket",
    "*.device",
    "*.mount",
    "*.automount",
    "*.swap",
    "*.target",
    "*.path",
    "*.timer",
    "*.slice",
    "*.scope",
  },
  callback = function()
    vim.opt_local.filetype = "systemd"
    vim.opt_local.syntax = "systemd"
  end,
  desc = "systemd.unit",
})

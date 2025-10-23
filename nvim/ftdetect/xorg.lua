vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*.Xresources",
    "*.Xdefaults",
    "*.Xmodmap",
  },
  callback = function()
    vim.opt_local.filetype = "xdefaults"
    vim.opt_local.syntax = "xdefaults"
  end,
  desc = "Xdefaults",
})

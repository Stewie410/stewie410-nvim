vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*.tex",
  },
  callback = function()
    vim.opt_local.filetype = "tex"
    vim.opt_local.syntax = "tex"
  end,
  desc = "TeX Support",
})

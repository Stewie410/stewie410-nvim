-- fake dosini
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*stunnel.conf",
  },
  callback = function()
    vim.opt_local.filetype = "dosini"
    vim.opt_local.syntax = "dosini"
  end,
})

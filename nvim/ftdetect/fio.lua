vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.fio" },
  callback = function()
    vim.opt_local.filetype = "dosini"
    vim.opt_local.syntax = "dosini"
  end,
  desc = "FIO Jobfile Support",
})

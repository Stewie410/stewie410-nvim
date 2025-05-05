vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.cron" },
  callback = function()
    vim.opt_local.filetype = "crontab"
    vim.opt_local.syntax = "crontab"
  end,
  desc = "Crontab support for docker/compose projects",
})

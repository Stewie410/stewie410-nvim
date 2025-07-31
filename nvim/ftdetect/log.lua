vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.log" },
  callback = function()
    vim.opt_local.filetype = "log"
    vim.opt_local.syntax = "log"
  end,
  desc = "Log Filetype",
})

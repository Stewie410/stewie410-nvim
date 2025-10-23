vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.ahk", "*.autohotkey", "*.ah1", "*.ah2", "*.ahk1", "*.ahk2" },
  callback = function()
    vim.opt_local.filetype = "autohotkey"
    vim.opt_local.syntax = "autohotkey"
  end,
  desc = "AutoHotKey Support (v1/v2)",
})

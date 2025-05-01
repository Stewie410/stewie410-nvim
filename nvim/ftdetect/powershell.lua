vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*.ps1",
    "*.psm1",
    "*.psd1",
  },
  callback = function()
    vim.opt_local.filetype = "powershell"
    vim.opt_local.syntax = "powershell"
  end,
  desc = "Use 'powershell' instead of 'ps1' for ft",
})

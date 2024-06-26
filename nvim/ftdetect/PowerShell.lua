vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.ps1", "*.psm1", "*.psd1" },
  callback = function()
    vim.opt_local.filetype = "PowerShell"
    vim.opt_local.syntax = "ps1"
    vim.opt_local.colorcolumn = "120"
    vim.opt_local.smartindent = false
  end,
  desc = "PowerShell Support",
})

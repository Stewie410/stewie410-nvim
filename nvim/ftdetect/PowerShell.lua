vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.ps1", "*.psm1", "*.psd1" },
  callback = function()
    vim.bo.filetype = "PowerShell"
    vim.bo.syntax = "ps1"
    vim.bo.colorcolumn = "120"
  end,
  desc = "PowerShell Support",
})

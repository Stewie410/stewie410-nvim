vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*.groovy",
    "*.gvy",
    "*.gy",
    "*.gsh",
  },
  callback = function()
    vim.opt_local.filetype = "groovy"
    vim.opt_local.syntax = "java"
  end,
  desc = "Groovy support",
})

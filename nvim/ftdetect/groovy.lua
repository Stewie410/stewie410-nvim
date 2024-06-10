vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.groovy", "*.gvy", "*.gy", "*.gsh" },
  callback = function()
    vim.bo.filetype = "groovy"
    vim.bo.syntax = "java"
  end,
  desc = "Groovy support",
})

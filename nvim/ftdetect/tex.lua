vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tex" },
  callback = function()
    vim.bo.filetype = "tex"
    vim.bo.syntax = "tex"
  end,
  desc = "TeX Support",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*README*.txt",
    "*TODO*.txt",
  },
  callback = function()
    vim.opt_local.filetype = "markdown"
    vim.opt_local.syntax = "markdown"
  end,
  desc = "Assume 'README.txt' files are Markdown",
})

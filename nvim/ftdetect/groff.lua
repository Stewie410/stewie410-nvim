vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*.ms",
    "*.me",
    "*.mom",
    "*.man",
  },
  callback = function()
    vim.opt_local.filetype = "groff"
    vim.opt_local.syntax = "groff"
  end,
  desc = "Assume GNU-Roff",
})

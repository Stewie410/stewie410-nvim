vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.ms", "*.me", "*.mom", "*.man" },
  callback = function()
    vim.bo.filetype = "groff"
    vim.bo.syntax = "groff"
  end,
  desc = "Assume GNU-Roff",
})

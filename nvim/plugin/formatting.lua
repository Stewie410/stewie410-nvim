vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  group = vim.api.nvim_create_augroup("format-on-save", { clear = true }),
  callback = function()
    local position = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", position)
  end,
  desc = "Trim trailing whitespace",
})

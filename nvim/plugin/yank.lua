vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = { "*" },
  group = vim.api.nvim_create_augroup("yank-highlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = "150" })
  end,
  desc = "Highlight text on yank",
})

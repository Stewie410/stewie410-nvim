vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.json" },
  callback = function()
    vim.bo.filetype = "jsonc"
    vim.bo.syntax = "jsonc"
  end,
  desc = "Always assume JSON is JSONC",
})

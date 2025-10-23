vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*.json",
  },
  callback = function()
    vim.opt_local.filetype = "jsonc"
    vim.opt_local.syntax = "jsonc"
  end,
  desc = "Always assume JSON is JSONC",
})

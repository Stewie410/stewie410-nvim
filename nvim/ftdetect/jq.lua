vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.jq" },
  callback = function()
    vim.opt_local.filetype = "jq"
    vim.opt_local.syntax = "jq"
  end,
  desc = "JQ Support",
})

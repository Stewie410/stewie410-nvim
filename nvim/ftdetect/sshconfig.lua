vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".ssh/config.d/*" },
  callback = function()
    vim.opt_local.filetype = "sshconfig"
    vim.opt_local.syntax = "sshconfig"
  end,
})

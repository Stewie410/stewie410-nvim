vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    ".ssh/config.d/*.conf",
    "/etc/ssh/ssh_config.d/*.conf",
  },
  callback = function()
    vim.opt_local.filetype = "sshconfig"
    vim.opt_local.syntax = "sshconfig"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "/etc/ssh/sshd_config.d/*.conf",
  },
  callback = function()
    vim.opt_local.filetype = "sshdconfig"
    vim.opt_local.syntax = "sshdconfig"
  end,
})

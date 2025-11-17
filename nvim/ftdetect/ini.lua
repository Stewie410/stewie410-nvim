-- fake dosini
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*stunnel.conf",
    "*my.cnf",
    ".dbpwd",
    "*/fail2ban/*.conf",
    "*/fail2ban/*.local",
  },
  callback = function()
    vim.opt_local.filetype = "dosini"
    vim.opt_local.syntax = "dosini"
  end,
  desc = "dosini-like syntax"
})

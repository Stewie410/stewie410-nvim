-- apache2 config & load files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*/apache/*.conf",
    "*/apache2/*.conf",
    "*/httpd/*.conf",
    "*/apache/*.load",
    "*/apache2/*.load",
    "*/httpd/*.load",
  },
  callback = function()
    vim.opt_local.filetype = "apache"
    vim.opt_local.syntax = "apache"
  end,
})

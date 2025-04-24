local cmd = vim.api.nvim_create_user_command

cmd("FTD", "filetype detect", { desc = "Force filetype detection" })

cmd("LSPC", function()
  print(vim.inspect(vim.lsp.get_clients()))
end, { desc = "View active LSP clients & info" })

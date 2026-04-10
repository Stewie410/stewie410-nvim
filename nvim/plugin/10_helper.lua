vim.api.nvim_create_user_command("FTD", "filetype detect", {
  desc = "Force filetype detection",
})

vim.api.nvim_create_user_command("LSPC", function()
  print(vim.inspect(vim.lsp.get_clients()))
end, { desc = "View active LSP client(s) info" })

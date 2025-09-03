local ok, _ = pcall(vim.cmd.colorscheme, "ayu")
if not ok then
  vim.cmd.colorscheme("default")
end

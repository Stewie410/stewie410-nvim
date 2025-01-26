vim.keymap.set("n", "<CR>", function()
  if vim.o.hlsearch then
    vim.cmd.nohl()
    return ""
  end
  return "<CR>"
end, { expr = true, desc = "Toggle hlsearch" })

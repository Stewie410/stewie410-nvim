vim.keymap.set("n", "[b", vim.cmd.bprevious, { desc = "Prev. Buffer" })
vim.keymap.set("n", "]b", vim.cmd.bnext, { desc = "Next Buffer" })

vim.keymap.set("n", "<leader>qf", vim.diagnostic.setloclist, { desc = "Quickfix List" })

vim.keymap.set("n", "<CR>", function()
  if vim.o.hlsearch then
    vim.cmd.nohl()
    return ""
  end
  return "<CR>"
end, { expr = true, desc = "Toggle hlsearch" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Escape Terminal" })
vim.keymap.set("n", "<leader>ot", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.startinsert()
end, { desc = "Open Terminal" })

vim.keymap.set("n", "<leader>pu", function() vim.pack.update() end, { desc = "vim.pack.update()" })
vim.keymap.set("n", "<leader>pr", function()
  vim.pack.update(nil, { target = "lockfile", force = true })
end, { desc = "vim.pack.update(): pinned to lockfile" })
vim.keymap.set("n", "<leader>pi", function()
  vim.pack.update(nil, { offline = true })
end, { desc = "vim.pack: plugin info" })

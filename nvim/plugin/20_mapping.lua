-- buffer {{{
vim.keymap.set("n", "[b", vim.cmd.bprevious, { desc = "Prev. Buffer" })
vim.keymap.set("n", "]b", vim.cmd.bnext, { desc = "Next Buffer" })
-- }}}

-- diagnostics {{{
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, {
  desc = "Prev. Diagnostic",
})
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, {
  desc = "Next Diagnostic",
})

vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>qf", vim.diagnostic.setloclist, { desc = "Quickfix List" })
-- }}}

-- toggle hl-search {{{
vim.keymap.set("n", "<CR>", function()
  if vim.o.hlsearch then
    vim.cmd.nohl()
    return ""
  end
  return "<CR>"
end, { expr = true, desc = "Toggle hlsearch" })
-- }}}

-- number inc/dec {{{
vim.keymap.set({ "n", "v" }, "+", "<C-a>", { desc = "+1" })
vim.keymap.set({ "n", "v" }, "-", "<C-d>", { desc = "-1" })
-- }}}

-- splits {{{
vim.keymap.set("n", "<C-=>", "<C-w>=", { desc = "Reset splits size" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Split-Nav: Left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Split-Nav: Down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Split-Nav: Up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Split-Nav: Right" })
-- }}}

-- terminal {{{
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Escape Terminal" })
vim.keymap.set("n", "<leader>ot", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.startinsert()
end, { desc = "Open Terminal" })
-- }}}

-- vim.pack {{{
vim.keymap.set("n", "<leader>pu", function() vim.pack.update() end, { desc = "vim.pack.update()" })
vim.keymap.set("n", "<leader>pr", function()
  vim.pack.update(nil, { target = "lockfile", force = true })
end, { desc = "vim.pack.update(): pinned to lockfile" })
vim.keymap.set("n", "<leader>pi", function()
  vim.pack.update(nil, { offline = true })
end, { desc = "vim.pack: plugin info" })
-- }}}

local map = vim.keymap.set

-- sane defaults for terminal buffers
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = vim.api.nvim_create_augroup("term-open", {}),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
    vim.opt_local.sidescrolloff = 0
    vim.opt_local.spell = false
  end,
  desc = "Sane defaults for terminal buffers",
})

-- easier escapes
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Easier terminal escapes" })

-- easily open a terminal split in insert-mode
map("n", "<leader>ot", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.startinsert()
end, { desc = "[O]pen [T]erminal" })

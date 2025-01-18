local map = vim.keymap.set

-- sane defaults for terminal buffers
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = { "term://" },
  group = vim.api.nvim_create_augroup("term-open", {}),
  callback = function()
    local opt = {
      number = false,
      relativenumber = false,
      scrolloff = 0,
      sidescrolloff = 0,
      spell = false,
      signcolumn = "no",
      filetype = "terminal",
      cursorline = false,
    }

    for k, v in pairs(opt) do
      vim.opt_local[k] = v
    end
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

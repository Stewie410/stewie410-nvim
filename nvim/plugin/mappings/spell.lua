vim.keymap.set("n", "<leader>sc", function()
  vim.opt.spell = not vim.o.spell
end, { desc = "Toggle [S]pell [C]heck" })

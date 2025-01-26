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

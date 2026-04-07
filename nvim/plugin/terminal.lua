vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = { "term://" },
  callback = function()
    vim.bo.number = false
    vim.bo.relativenumber = false
    vim.bo.scrolloff = 0
    vim.bo.sidescrolloff = 0
    vim.bo.spell = false
    vim.bo.signcolumn = "no"
    vim.bo.filetype = "terminal"
    vim.bo.cursorline = false
  end,
  desc = "Sane defaults for terminal buffers",
})

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
    if bg then
      io.write(string.format("\027]11;#%07x\027\\", bg))
    end
    vim.api.nvim_create_autocmd({ "UILeave" }, {
      callback = function()
        io.write("\027]111\027\\")
      end,
      desc = "Reset terminal background color",
    })
  end,
  desc = "Corrects terminal background according to colorscheme",
})

local group = vim.api.nvim_create_augroup("nvim-winux", { clear = true })

-- resize splits when terminal/nvim is resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = group,
  callback = function()
    local tab = vim.api.nvim_get_current_tabpage()
    vim.cmd("tabdo wincmd -")
    vim.api.nvim_set_current_tabpage(tab)
  end,
  desc = "Auto-resize splits when terminal window size changes",
})

-- fixes terminal bg according to nvim colorscheme
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  group = group,
  callback = function()
    local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
    if bg then
      io.write(string.format("\027]11;#%07x\027\\", bg))
    end
    vim.api.nvim_create_autocmd({ "UILeave" }, {
      group = group,
      callback = function()
        io.write("\027]111\027\\")
      end,
      desc = "Reset terminal background color",
    })
  end,
  desc = "Corrects terminal background according to colorscheme",
})

-- jump to last cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  group = group,
  callback = function(args)
    local pos = vim.api.nvim_buf_get_mark(args.buf, '"')
    local winid = vim.fn.bufwinid(args.buf)
    pcall(vim.api.nvim_win_set_cursor, winid, pos)
  end,
  desc = "Auto-jump back to last know cursor position",
})

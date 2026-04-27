-- General {{{
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    local tab = vim.api.nvim_get_current_tabpage()
    local ch = vim.o.cmdheight
    vim.cmd("tabdo wincmd -")
    vim.api.nvim_set_current_tabpage(tab)
    vim.o.cmdheight = ch
  end,
  desc = "Resize splits when nvim resized",
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = "150" })
  end,
  desc = "Highlight text on yank",
})

-- don't auto-wrap comments, don't insert comment-leader on 'o'
vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    vim.cmd("setlocal formatoptions-=c formatoptions-=o")
  end,
  desc = "better comment-edit dx",
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function()
    local position = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", position)
  end,
  desc = "Trim trailing whitespace"
})

vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
  pattern = {
    "help",
    "startuptime",
    "qf",
    "lspinfo",
    "man",
    "checkhealth",
    "neotest-output-panel",
    "neotest-summary",
    "lazy",
    "mason",
  },
  callback = function()
    vim.keymap.set("n", "q", ":close<CR>", { silent = true, buffer = true, desc = "Quit" })
    vim.keymap.set("n", "<Esc>", ":close<CR>", { silent = true, buffer = true, desc = "Quit" })
  end,
  desc = "q/<Esc> always quits",
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  callback = function()
    local exclude = {
      "gitcommit",
    }

    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local len = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= len then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
      vim.api.nvim_feedkeys('zvzz', 'n', true)
    end
  end,
  desc = "Restore cusor position",
})

-- }}}
-- Terminal {{{
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

-- }}}

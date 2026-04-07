-- vim.g {{{
local leader = " "
vim.g.mapleader = leader
vim.g.maplocalleader = leader
vim.g.gitblame_enabled = 0
vim.g.have_nerd_font = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_banner = 0
vim.g.showbreak = "↪"
vim.g.showmatch = true
-- }}}

-- vim.o {{{
local tabstop = 4
local scroll_off = 10
local cmd_height = 1

vim.o.encoding = "UTF-8"
vim.o.background = "dark"
vim.o.number = true
-- vim.o.ruler = true
vim.o.mouse = "a"
vim.o.showmode = false
-- vim.o.wildmode = 'longest,list,full'
-- vim.o.updatetime = 0
vim.o.termguicolors = true
vim.o.timeoutlen = 300
-- vim.o.backup = false
vim.o.hidden = true
-- vim.o.swapfile = false
vim.o.colorcolumn = "80"
-- vim.o.clipboard = "unnamedplus"

vim.o.cmdheight = cmd_height
vim.o.cmdwinheight = cmd_height
vim.o.signcolumn = "yes"
vim.o.pumheight = 10
vim.o.cursorline = true
vim.o.modeline = true

vim.o.smarttab = true
vim.o.smartindent = true
vim.o.breakindent = true
vim.o.wrap = true
vim.o.tabstop = tabstop
vim.o.softtabstop = tabstop
vim.o.shiftwidth = tabstop
vim.o.shiftround = true
vim.o.expandtab = true
vim.o.emoji = true

vim.o.splitright = true
vim.o.splitbelow = true
vim.o.splitkeep = "screen"

vim.o.foldenable = false
-- vim.o.foldcolumn = "1"
vim.o.foldlevel = 0
vim.o.foldlevelstart = 0
vim.o.foldmethod = "marker"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.o.scrolloff = scroll_off
vim.o.sidescrolloff = scroll_off

vim.o.hlsearch = true
vim.o.inccommand = "split"
vim.o.shada = { "'10", "<0", "s10", "h" }
vim.o.smartcase = true
vim.o.ignorecase = true

vim.o.list = true
vim.o.completeopt = { "menu", "menuone", "noselect" }
-- }}}

-- vim.o.undo* {{{
local parent = vim.fn.expand(vim.fn.stdpath("cache") .. "/undo")
vim.fn.mkdir(parent, "p")

vim.o.undo = parent
vim.o.undofile = true
vim.o.undolevels = 1000
-- }}}

-- User Commands {{{
vim.api.nvim_create_user_command("FTD", "filetype detect", {
  desc = "Force filetype detection",
})

vim.api.nvim_create_user_command("LSPC", function() print(vim.inspect(vim.lsp.get_clients())) end, {
  desc = "View active LSP Client Info",
})
-- }}}

-- Trim whitespace {{{
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function()
    local position = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", position)
  end,
  desc = "Trim trailing whitespace"
})
-- }}}

-- Terminals {{{
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

-- Yank Highlight {{{
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = "150" })
  end,
  desc = "Highlight text on yank",
})
-- }}}

-- Resize splits when nvim window resized
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
-- }}}

-- jump to last cursor position {{{
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  callback = function(args)
    local pos = vim.api.nvim_buf_get_mark(args.buf, '"')
    local winid = vim.fn.bufwinid(args.buf)
    pcall(vim.api.nvim_win_set_cursor, winid, pos)
  end,
  desc = "Auto-jump back to last know cursor position",
})
-- }}}

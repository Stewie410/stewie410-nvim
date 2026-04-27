-- General {{{
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.encoding = "UTF-8"
vim.o.mouse = "a"
vim.o.switchbuf = "usetab"
vim.o.undofile = true
vim.o.hidden = true
vim.g.showmatch = true

vim.o.modeline = true

vim.o.timeoutlen = 300

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_banner = 0

vim.g.gitblame_enabled = 0

-- limit ShaDa for startuptime
vim.o.shada = "'100,<50,s10,:1000,/100,@100,h"

-- Enable all ft plugisn & syntax for better startuptime
vim.cmd("filetype plugin indent on")
if vim.fn.exists("syntax_on") ~= 1 then
  vim.cmd("syntax enable")
end

-- }}}
-- UI {{{
vim.o.background = "dark"
vim.o.showmode = false
vim.o.termguicolors = true
vim.g.have_nerd_font = true
vim.o.emoji = true

vim.o.breakindent = true
vim.o.breakindentopt = "list:-1"

vim.o.colorcolumn = "+1"
vim.o.cursorline = true
vim.o.cursorlineopt = "screenline,number"
vim.o.linebreak = true
vim.o.wrap = true

vim.o.list = true

vim.o.number = true
vim.o.ruler = false

vim.o.winborder = "single"
vim.o.pumborder = "single"
vim.o.pumheight = 10
vim.o.pummaxwidth = 100

vim.o.signcolumn = "yes"

vim.o.splitbelow = true
vim.o.splitright = true
vim.o.splitkeep = "screen"

vim.o.cmdheight = 1
vim.o.cmdwinheight = 1

vim.o.fillchars = "eob: ,fold:╌"
vim.o.listchars = "extends:»,nbsp:░,precedes:«,trail:·"
vim.o.showbreak = "↪"

vim.o.foldenable = false
vim.o.foldlevel = 0
vim.o.foldlevelstart = 0
vim.o.foldmethod = "marker"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldnestmax = 10
vim.o.foldtext = ""

vim.o.scrolloff = 10
vim.o.sidescrolloff = 10

-- }}}
-- Editing {{{
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.formatoptions = "rqnl1j"

vim.o.hlsearch = true
vim.o.inccommand = "split"
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.infercase = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.shiftround = true
vim.o.expandtab = true

vim.o.smartcase = true

vim.o.spelloptions = "camel"

vim.o.virtualedit = "block"

-- Treat dash as "word" textobj part
vim.o.iskeyword = "@,48-57,_,192-255,-"

-- Pattern for a start of numbered list (used in `gw`). This reads as
-- "Start of list item is: at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space".
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

vim.o.complete = ".,w,b,kspell"
vim.o.completeopt = "menu,menuone,noselect"
vim.o.completetimeout = 100

-- }}}
-- Misc {{{
-- dbext workaround
vim.g.omni_sql_default_compl_type = 'syntax'
-- }}}

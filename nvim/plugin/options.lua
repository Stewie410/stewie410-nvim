vim.o.encoding = "UTF-8"
vim.o.mouse = "a"
vim.o.switchbuf = "usetab"
vim.o.undofile = true
vim.o.hidden = true
vim.o.showmatch = true

vim.o.timeoutlen = 300

vim.o.breakindent = true
vim.o.breakindentopt = "list:-1"

vim.o.splitbelow = true
vim.o.splitright = true
vim.o.splitkeep = "screen"

vim.o.scrolloff = 10
vim.o.sidescrolloff = 10

vim.o.autoindent = true
vim.o.smartindent = true
vim.o.formatoptions = "rqnl1j"

vim.o.tabstop = 4
vim.o.softtabstop = 0
vim.o.shiftwidth = 0
vim.o.shiftround = true
vim.o.expandtab = false

vim.o.spelloptions = "camel"

vim.o.virtualedit = "block"

-- Treat dash as "word" textobj part
vim.o.iskeyword = "@,48-57,_,192-255,-"

-- Pattern for a start of numbered list (used in `gw`). This reads as
-- "Start of list item is: at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space".
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- dbext workaround
vim.g.omni_sql_default_compl_type = 'syntax'

require("util.clipboard").setup()

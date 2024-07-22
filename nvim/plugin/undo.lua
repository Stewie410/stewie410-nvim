local parent = vim.fn.expand(vim.fn.stdpath("cache") .. "/undo")

vim.fn.mkdir(parent)

vim.opt.undodir = parent
vim.opt.undofile = true
vim.opt.undolevels = 1000

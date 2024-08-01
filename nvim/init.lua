-- Set <leader> before lazy to avoid problems
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ import = "custom/plugins" }, {
  dev = {
    path = "~/git/plugins",
    fallback = true,
  },
  defaults = {
    lazy = true,
    version = false,
  },
  install = {
    colorscheme = {
      "ayu",
      "tokyonight-night",
      "habamax",
    },
  },
  rocks = { hererocks = true },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "gzip",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

local tabstop = 4
local scroll_off = 10

local options = {
  opt = {
    encoding = "UTF-8",
    number = true,
    -- ruler = true,
    mouse = "a",
    showmode = false,
    smarttab = true,
    smartindent = true,
    breakindent = true,
    wrap = true,
    tabstop = tabstop,
    softtabstop = tabstop,
    shiftwidth = tabstop,
    shiftround = true,
    expandtab = true,
    emoji = true,
    -- wildmode = 'longest,list,full',
    splitright = true,
    splitbelow = true,
    splitkeep = "screen",
    signcolumn = "yes",
    foldenable = false,
    foldcolumn = "1",
    foldlevel = 99,
    foldmethod = "expr",
    foldexpr = "v:lua.vim.treesitter.foldexpr()",
    -- updatetime = 0,
    scrolloff = scroll_off,
    sidescrolloff = scroll_off,
    hlsearch = true,
    pumheight = 10,
    termguicolors = true,
    timeoutlen = 300,
    -- backup = false,
    cursorline = true,
    hidden = true,
    -- swapfile = false,
    colorcolumn = "80",
    -- clipboard = "unnamedplus",
    inccommand = "split",
    shada = { "'10", "<0", "s10", "h" },
    smartcase = true,
    ignorecase = true,
    list = true,
    background = "dark",
    completeopt = { "menu", "menuone", "noselect" },
    shortmess = (vim.opt.shortmess):append({ c = true }),
    formatoptions = (vim.opt.formatoptions):remove("o"),
    listchars = (vim.opt.listchars):append({
      trail = "·",
      extends = "»",
      precedes = "«",
      nbsp = "░",
    }),
  },
  g = {
    gitblame_enabled = 0,
    have_nerd_font = true,
    loaded_netrw = 1,
    loaded_netrwPlugin = 1,
    showbreak = "↪",
    showmatch = true,
    netrw_banner = 0,
  },
}

for k, v in pairs(options.opt) do
  vim.opt[k] = v
end

for k, v in pairs(options.g) do
  vim.g[k] = v
end

local sf = require("util.spellfile")
sf.setup()

local ud = require("util.undodir")
ud.setup()

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
    expandtab = true,
    emoji = true,
    -- wildmode = 'longest,list,full',
    splitright = true,
    splitbelow = true,
    splitkeep = "screen",
    signcolumn = "yes",
    foldcolumn = "1",
    -- updatetime = 0,
    scrolloff = scroll_off,
    sidescrolloff = scroll_off,
    hlsearch = true,
    pumheight = 10,
    termguicolors = true,
    timeoutlen = 300,
    undofile = true,
    undolevels = 1000,
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
  },
  g = {
    gitblame_enabled = 0,
    have_nerd_font = true,
    loaded_netrw = 1,
    loaded_netrwPlugin = 1,
    showbreak = "↪",
    showmatch = true,
  },
}

for type, list in pairs(options) do
  for option, value in pairs(list) do
    (vim[type])[option] = value
  end
end

-- Don't give completion menus in interactive prompts
vim.opt.shortmess:append({ c = true })

-- Don't create a comment on 'o'
vim.opt.formatoptions:remove("o")

-- Show invisible chars
vim.opt.listchars:append({
  trail = "·",
  extends = "»",
  precedes = "«",
  nbsp = "░",
})

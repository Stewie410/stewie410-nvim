local function spell_file()
  local path = vim.fn.expand(vim.fn.stdpath("config") .. "/spell/en.utf-8.add")

  if not vim.uv.fs_stat(path) then
    vim.fn.mkdir(vim.fs.dirname(path), "p")
    local status_ok, f = pcall(assert, io.open(path, "w"))

    if not status_ok then
      vim.notify("Failed to create spellfile: " .. path, vim.log.levels.WARN)
      return ""
    end

    f:close()
  end

  return path
end

local function undo_dir()
  local path = vim.fn.expand(vim.fn.stdpath("cache") .. "/undo")
  vim.fn.mkdir(path, "p")
  return path
end

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
    undodir = undo_dir(),
    undofile = true,
    undolevels = 1000,
    -- backup = false,
    cursorline = true,
    hidden = true,
    -- swapfile = false,
    colorcolumn = "80",
    clipboard = "unnamedplus",
    inccommand = "split",
    shada = { "'10", "<0", "s10", "h" },
    smartcase = true,
    ignorecase = true,
    list = true,
    background = "dark",
    spelllang = { "en_us" },
    spellfile = spell_file(),
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

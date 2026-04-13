local M = {}

local function install(langs, wait)
  assert(vim.tbl_count(langs) > 0, "utils.ts.setup(): must specify at least 1 parser language")
  vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
  require("nvim-treesitter").install(langs):wait(wait)
end

local function enable_fold()
  vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.wo[0][0].foldmethod = "expr"
end

local function enable_indent()
  -- WARN: experimental
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

---@class ts.Config
---@field wait? number milliseconds to wait when installing (default: 5m)
---@field fold? boolean enable treesitter folding
---@field indent? boolean enable treesitter indentation (WARN: experimental)

---Setup treesitter parsers & features
---@link https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
---@param langs string[] nvim-treesitter parsers to install
---@param opts? ts.Config
function M.setup(langs, opts)
  local defaults = {
    wait = 300000,
    fold = false,
    indent = false,
  }
  opts = vim.tbl_extend("force", defaults, opts or {})

  install(langs, opts.wait)
  vim.treesitter.start()
  if opts.fold then enable_fold() end
  if opts.indent then enable_indent() end
end

return M

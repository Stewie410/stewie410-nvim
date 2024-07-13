local M = {}

local defaults = {
  paths = {
    vim.fn.stdpath("cache") .. "/undo",
  },
  undo = {
    file = true,
    levels = 1000,
  },
}

M.options = {}

---Create and apply undodir
---@param opts? table
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", {}, defaults, opts or {})

  M.options.path = vim.tbl_map(function(path)
    vim.fn.mkdir(path, "p")
  end, M.options.paths)

  vim.opt.undodir = M.options.paths
  vim.opt.undofile = M.options.undo.file
  vim.opt.undolevels = M.options.undo.levels
end

return M

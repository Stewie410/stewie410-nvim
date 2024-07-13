local M = {}

local uv = vim.uv or vim.loop

local defaults = {
  paths = {
    vim.fn.stdpath("cache") .. "/undo", -- global
  },
}

M.paths = {}

---mkdir --parents <path>
---@param path string
local function mkdir(path)
  if not uv.fs_stat(path) then
    vim.fn.mkdir(path, "p")
  end
end

---Create and apply undodir
---@param options table
function M.setup(options)
  local opts = vim.tbl_deep_extend("force", {}, defaults, options or {})

  for _, v in ipairs(opts.paths) do
    mkdir(v)
    table.insert(M.paths, v)
  end

  vim.opt.undodir = table.concat(M.paths, ",")
end

return M

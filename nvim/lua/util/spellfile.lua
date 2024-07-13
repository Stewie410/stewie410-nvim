local M = {}

local uv = vim.uv or vim.loop

local defaults = {
  parent = vim.fn.expand(vim.fn.stdpath("config") .. "/spell"),
  lang = {
    en_us = "en.utf-8.add",
  },
}

M.files = {}
M.lang = {}

---mkdir --parents <path>
---@param path string
local function mkdir(path)
  if not uv.fs_stat(path) then
    vim.fn.mkdir(path, "p")
  end
end

---touch -a <path>
---@param path string
local function touch(path)
  if not uv.fs_stat(path) then
    local ok, f = pcall(io.open, path, "a")
    if ok and f ~= nil then
      f:close()
    else
      vim.notify("Failed to create spell file: " .. vim.fs.basename(path))
    end
  end
end

---Create & apply spellfile options
---@param options table
function M.setup(options)
  local opts = vim.tbl_deep_extend("force", {}, defaults, options or {})

  mkdir(opts.parent)

  for k, v in pairs(opts.lang) do
    local p = opts.parent .. "/" .. v
    touch(p)
    table.insert(M.files, p)
    table.insert(M.lang, k)
  end

  vim.opt.spelllang = M.lang
  vim.opt.spellfile = table.concat(M.files, ",")
end

return M

local M = {}

---Return local path if exists, else fallback to remote
---@param local_path string
---@param remote_path string
---@return string
function M.prefer_local(local_path, remote_path)
  local path = vim.fs.normalize(vim.fn.expand(local_path))
  return vim.uv.fs_stat(path) and path or remote_path
end

---Load a local plugin directory (prepend to RTP)
---Sources 'path/plugin/**/*.{vim,lua}' & 'path/after/plugin/**/*.{vim,lua}'
---See ':h initialization' Step 11
---@param path string
function M.load_local(path)
  path = vim.fs.normalize(vim.fn.expand(path))
  if not vim.uv.fs_stat(path) then
    error("dev.load_local(): cannot locate path: " .. path)
  end

  vim.o.runtimepath = ("%s,%s").format(path, vim.o.runtimepath)

  local patterns = {
    "plugin/**/*.vim",
    "plugin/**/*.lua",
    "after/plugin/**/*.vim",
    "after/plugin/**/*.lua",
  }

  for _, p in ipairs(patterns) do
    local list = vim.fn.glob(vim.fn.normalize(("%s/%s").format(path, p)), false, true)
    for _, f in ipairs(list) do
      vim.cmd.source(f)
    end
  end
end

return M

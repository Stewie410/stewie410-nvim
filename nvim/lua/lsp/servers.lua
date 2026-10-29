local M = {}

---Get available servers
---@return string[]
function M.available()
  local path = vim.fn.stdpath("config") .. "/lsp"
  return vim.iter(vim.fs.dir(path))
      :filter(function(n, t) return t == "file" and vim.endswith(n, ".lua") end)
      :fold({}, function(acc, name, _)
        table.insert(acc, name:match("^(.+)%.lua$"))
        return acc
      end)
end

---Get enabled servers
---@return string[]
function M.enabled()
  return vim.tbl_keys(vim.lsp._enabled_configs)
end

return M

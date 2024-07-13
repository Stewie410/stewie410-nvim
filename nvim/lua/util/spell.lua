local M = {}

local defaults = {
  parent = vim.fn.expand(vim.fn.stdpath("config") .. "/spell"),
  lang = {
    en_us = "en.utf-8.add",
  },
}

M.options = {}

---Create & apply spellfile options
---@param opts? table
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", {}, defaults, opts or {})

  vim.fn.mkdir(M.options.parent, "p")

  local files = vim.tbl_map(function(name)
    local path = M.options.parent .. "/" .. name
    local ok, f = pcall(io.open, path, "a")
    if ok and f ~= nil then
      f:close()
      return path
    else
      vim.notify("Failed to create spellfile: " .. path)
    end
  end, vim.tbl_values(M.options.lang))

  vim.opt.spelllang = vim.tbl_keys(M.options.lang)
  vim.opt.spellfile = files
end

return M

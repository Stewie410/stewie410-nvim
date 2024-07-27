local M = {}

---Remove duplicate entries in a list
---@param list any[] List<T>
---@return any[]
function M.dedup(list)
  local t = {}
  local seen = {}

  for _, v in ipairs(list) do
    if not seen[v] then
      table.insert(t, v)
      seen[v] = true
    end
  end

  return t
end

return M

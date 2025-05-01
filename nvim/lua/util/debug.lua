local M = {}

---Get path to stack item, relative to CWD
---@param stack integer stack item to reference, default 2 (immediate caller)
---@return string|nil
function M.script_path(stack)
  local ok, t = pcall(debug.getinfo, stack or 2, "S")
  return ok and t.source:sub(2) or nil
end

return M

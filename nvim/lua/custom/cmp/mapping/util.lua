local M = {}

function M.get_cmp()
  local ok, cmp = pcall(require, "cmp")
  return ok and cmp or {}
end

function M.get_luasnip()
  local ok, luasnip = pcall(require, "luasnip")
  return ok and luasnip or {}
end

return M

local M = {}

---@alias util.mapper.Mode "n"|"v"|"x"|"s"|"o"|"i"|"c"|"t"|"!"|"ia"|"ca"|"!a"

---@class util.mapper.KeySpec
---@field [1] string  lhs
---@field [2] string|fun():any? rhs
---@field mode? util.mapper.Mode|util.mapper.Mode[] mode(s) to create mapping, "n" if nil
---@field desc? string description
---@field noremap? boolean non-recursive
---@field remap? boolean recusive
---@field expr? boolean rhs should be evaluated to get rhs key(s)
---@field nowait? boolean don't wait for other keys for map matching
---@field silent? boolean don't echo to cmdline
---@field script? boolean only map rhs using script-local mappings
---@field unique? boolean abort mapping if lhs already defined elsewhere
---@field bufnr? integer|boolean buffer-local mapping, 0 or true uses current buffer
---@field replace_keycodes? boolean when rhs is an expression, replace keycodes of resulting string

---@class util.mapper.DelSpec
---@field [1] string lhs
---@field mode? util.mapper.Mode|util.mapper.Mode[] mode(s) to remove mapping from
---@field bufnr? integer|boolean remove mapping from buffer, 0 or true uses the current buffer

---Set keymap
---@param keymap util.mapper.KeySpec keymap spec
function M.set(keymap)
  vim.keymap.set(keymap.mode or "n", keymap[1], keymap[2], {
    desc = keymap.desc or "",
    noremap = keymap.noremap or false,
    remap = keymap.remap or false,
    expr = keymap.expr or false,
    nowait = keymap.nowait or false,
    silent = keymap.silent or false,
    script = keymap.script or false,
    unique = keymap.unique or false,
    buffer = keymap.bufnr or false,
    replace_keycodes = (keymap.expr and keymap.replace_keycodes) or false,
  })
end

---Set unique keymap (E227)
---@param keymap util.mapper.KeySpec keymap spec
function M.set_unique(keymap)
  keymap.unique = true
  M.set(keymap)
end

---Remove keymap
---@param delmap util.mapper.DelSpec keymap spec
function M.del(delmap)
  vim.keymap.del(delmap.mode or "n", delmap[1], {
    buffer = delmap.bufnr or false,
  })
end

return M

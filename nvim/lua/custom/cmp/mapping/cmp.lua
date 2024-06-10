-- based heavily on lsp-zero's impl
-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/lua/lsp-zero/cmp-mapping.lua#L22

local M = {}

local util = require("custom.cmp.mapping.util")

---Enables completion when the cursor is inside a word.  If the completion menu
---is visible, it will navigate to the next item in the list.  If the line is
---empty, it uses the fallback.
---@param select_opts? cmp.SelectOption
---@return cmp.Mapping
function M.tab_complete(select_opts)
  local cmp = util.get_cmp()

  return cmp.mapping(function(fallback)
    local col = vim.fn.col(".") - 1

    if cmp.visible() then
      cmp.select_next_item(select_opts)
    elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
      fallback()
    else
      cmp.complete()
    end
  end, { "i", "s" })
end

---If the completion menu is visible, navigate to the previous item in the
---list.  Else, use the fallback.
---@param select_opts? cmp.SelectOption
---@return cmp.Mapping
function M.select_prev_or_fallback(select_opts)
  local cmp = util.get_cmp()

  return cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item(select_opts)
    else
      fallback()
    end
  end, { "i", "s" })
end

---If the completion menu is visible, it cancels the process.  Else, it
---triggers the completion menu.
---@param opts {modes?: string[]}
---@return cmp.Mapping
function M.toggle_completion(opts)
  opts = opts or {}
  local cmp = util.get_cmp()

  return cmp.mapping(function()
    if cmp.visible() then
      cmp.abort()
    else
      cmp.complete()
    end
  end, opts.modes)
end

return M

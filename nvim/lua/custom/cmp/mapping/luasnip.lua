-- based heavily on lsp-zero's impl
-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/lua/lsp-zero/cmp-mapping.lua#L202

local M = {}

local util = require("custom.cmp.mapping.util")

---Goto the next placeholder in a snippet created by luasnip
---@return cmp.Mapping
function M.luasnip_jump_forward()
  local cmp = util.get_cmp()
  local ls = util.get_luasnip()

  return cmp.mapping(function(fallback)
    if ls.jumpable(1) then
      ls.jump(1)
    else
      fallback()
    end
  end, { "i", "s" })
end

---Goto the previous placeholder in a snippet created by luasnip
---@return cmp.Mapping
function M.luasnip_jump_backward()
  local cmp = util.get_cmp()
  local ls = util.get_luasnip()

  return cmp.mapping(function(fallback)
    if ls.jumpable(-1) then
      ls.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" })
end

---If the completion menu is visible, navigate to the next item in the list.
---If the cursor is on top of the trigger of a snippet, expand it.  If the
---cursor can jump to a luasnip placeholder, move to it.  If the cursor is
---in the middle of a word that doesn't trigger a snippet, it displays the
---completion menu.  Else, it uses the fallback.
---@param select_opts? cmp.SelectOption
---@return cmp.Mapping
function M.luasnip_supertab(select_opts)
  local cmp = util.get_cmp()
  local ls = util.get_luasnip()

  return cmp.mapping(function(fallback)
    local col = vim.fn.col(".") - 1

    if cmp.visible() then
      cmp.select_next_item(select_opts)
    elseif ls.expand_or_jumpable() then
      ls.expand_or_jump()
    elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
      fallback()
    else
      cmp.complete()
    end
  end, { "i", "s" })
end

---If the completion menu is visible, navigate to previous item in the list.
---If the cursor can navigate to a previous snippet placeholder, it moves to
---it.  Else, it uses the fallback.
---@param select_opts? cmp.SelectOption
---@return cmp.Mapping
function M.luasnip_shift_supertab(select_opts)
  local cmp = util.get_cmp()
  local ls = util.get_luasnip()

  return cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item(select_opts)
    elseif ls.jumpable(-1) then
      ls.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" })
end

---If completion menu is visible, navigate to the next item in the list.  If
---cursor is on top of the trigger of a snippet, it'll expand it.  If the
---cursor can jump to a luasnip placeholder, it moves to it.  Else, it uses
---the fallback.
---@param select_opts? cmp.SelectOption
---@return cmp.Mapping
function M.luasnip_next_or_expand(select_opts)
  local cmp = util.get_cmp()
  local ls = util.get_luasnip()

  return cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item(select_opts)
    elseif ls.expand_or_jumpable() then
      ls.expand_or_jump()
    else
      fallback()
    end
  end, { "i", "s" })
end

---If completion menu is visible, navigate to the next item in the list.  If
---the cursor can jump to a luasnip placeholder, it moves to it.  Else, it
---uses the fallback.
---@param select_opts? cmp.SelectOption
---@return cmp.Mapping
function M.luasnip_next(select_opts)
  local cmp = util.get_cmp()
  local ls = util.get_luasnip()

  return cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item(select_opts)
    elseif ls.jumpable(1) then
      ls.jump(1)
    else
      fallback()
    end
  end, { "i", "s" })
end

---If completion menu is visible, navigate to the previous item in the list.
---If the cursor can jump to a luasnip placeholder, it moves to it.  Else, it
---uses the fallback.
---@param select_opts? cmp.SelectOption
---@return cmp.Mapping
function M.luasnip_prev(select_opts)
  local cmp = util.get_cmp()
  local ls = util.get_luasnip()

  return cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item(select_opts)
    elseif ls.jumpable(-1) then
      ls.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" })
end

return M

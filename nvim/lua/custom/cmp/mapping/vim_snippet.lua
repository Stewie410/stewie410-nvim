-- based heavily on lsp-zero's impl
-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/lua/lsp-zero/cmp-mapping.lua#L75

local M = {}
local s = {}

local util = require("custom.cmp.mapping.util")

local function vim_snippet_support()
  if s._vim_snippet == nil then
    s._vim_snippet = type(vim.tbl_get(vim, "snippet", "expand")) == "function"
  end
  return s._vim_snippet
end

local function vim_snippet_warn(name)
  vim.notify(
    "[stewie410-cmp] vim.snippet module is not available."
      .. "\ncmp action '"
      .. name
      .. "' will not work."
      .. "\nMake sure you are using Neovim v0.10 or greater.",
    vim.log.levels.WARN
  )
end

---Goto the next placeholder in a snippet created by the vim.snippet module
---@return cmp.Mapping|vim.NIL
function M.vim_snippet_jump_forward()
  local cmp = util.get_cmp()

  if not vim_snippet_support() then
    vim_snippet_warn("vim_snippet_jump_forward")
    return vim.NIL
  end

  return cmp.mapping(function(fallback)
    if vim.snippet.jumpable(1) then
      vim.snippet.jump(1)
    else
      fallback()
    end
  end, { "i", "s" })
end

---Goto the previous placeholder in a snippet created by the vim.snippet module
---@return cmp.Mapping|vim.NIL
function M.vim_snippet_jump_backward()
  local cmp = util.get_cmp()

  if not vim_snippet_support() then
    return vim.NIL
  end

  return cmp.mapping(function(fallback)
    if vim.snippet.jumpable(-1) then
      vim.snippet.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" })
end

---If completion menu is visible, navigate to the next item in the list.  If
---the cursor can jump to a vim snippet placeholder, it moves to it.  Else,
---it uses the fallback.
---@param select_opts? cmp.SelectOption
---@return cmp.Mapping|vim.NIL
function M.vim_snippet_next(select_opts)
  local cmp = util.get_cmp()

  if not vim_snippet_support() then
    vim_snippet_warn("vim_snippet_next")
    return vim.NIL
  end

  return cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item(select_opts)
    elseif vim.snippet.jumpable(1) then
      vim.snippet.jump(1)
    else
      fallback()
    end
  end, { "i", "s" })
end

---If completion menu is visible, navigate to the previous item in the list.
---If the cursor can jump to a vim snippet placeholder, it moves to it.  Else,
---it uses the fallback.
---@param select_opts? cmp.SelectOption
---@return cmp.Mapping|vim.NIL
function M.vim_snippet_prev(select_opts)
  local cmp = util.get_cmp()

  if not vim_snippet_warn() then
    return vim.NIL
  end

  return cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item(select_opts)
    elseif vim.snippet.jumpable(-1) then
      vim.snippet.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" })
end

---If the completion menu is visible, navigate to the next item in the list.
---If the cursor can jump to a vim snippet placeholder, it moves to it.  If
---the cursor is in the middle of a word, it displays the completion menu.
---Else, it uses the fallback.
---@param select_opts? cmp.SelectOption
---@return cmp.Mapping|vim.NIL
function M.vim_snippet_tab_next(select_opts)
  local cmp = util.get_cmp()

  if not vim_snippet_support() then
    vim_snippet_warn("vim_snippet_tab_next")
    return vim.NIL
  end

  return cmp.mapping(function(fallback)
    local col = vim.fn.col(".") - 1

    if cmp.visible() then
      cmp.select_next_item(select_opts)
    elseif vim.snippet.jumpable(1) then
      vim.snippet.jump(1)
    elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
      fallback()
    else
      cmp.complete()
    end
  end, { "i", "s" })
end

---If the completion menu is visible, navigate to the previous item in the
---list.  If the cursor can jump to a vim snippet placeholder, it moves to it.
---If hte cursor is in the middle of a word, it displays the completion menu.
---Else, it uses the fallback.
---@param select_opts? cmp.SelectOption
---@return cmp.Mapping|vim.NIL
function M.vim_snippet_tab_prev(select_opts)
  local cmp = util.get_cmp()

  if not vim_snippet_support() then
    return vim.NIL
  end

  return cmp.mapping(function(fallback)
    local col = vim.fn.col(".") - 1

    if cmp.visible() then
      cmp.select_prev_item(select_opts)
    elseif vim.snippet.jumpable(-1) then
      vim.snippet.jump(-1)
    elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
      fallback()
    else
      cmp.complete()
    end
  end, { "i", "s" })
end

return M

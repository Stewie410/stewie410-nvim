local parent = vim.fn.expand(vim.fn.stdpath("config") .. "/spell")
local opts = {
  en_us = "/en.utf-8.add",
}

if not vim.uv.fs_stat(parent) then
  vim.fn.mkdir(parent, "p")
end

local files = vim.tbl_map(function(fname)
  local path = parent .. "/" .. fname

  if vim.uv.fs_stat(path) then
    return
  end

  local ok, f = pcall(io.open, path, "a")
  if ok and f ~= nil then
    f:close()
    return path
  end
end, vim.tbl_values(opts))

vim.opt.spelllang = vim.tbl_keys(opts)
vim.opt.spellfile = files

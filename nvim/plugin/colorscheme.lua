local pref = "ayu"
local fb = "default"

local status_ok, _ = pcall(vim.cmd.colorscheme, pref)
if not status_ok then
  vim.notify(
    'Missing scheme "' .. pref .. '"\nFalling back to "' .. fb .. '"',
    vim.log.levels.WARN
  )
  vim.cmd.colorscheme(fb)
end

---Get absolute path to template files
---@return string
local function get_root()
  local root = "$XDG_CONFIG_HOME"

  if vim.fn.expand(root) == root then
    if vim.uv.os_uname().sysname == "Windows_NT" then
      root = "$LOCALAPPDATA"
    else
      root = "~/.config"
    end
  end

  return vim.fn.expand(root .. "/templates")
end

---Get path to template file, or nil.  Warn if no template found
---@return string?
local function get_template()
  local root = get_root()

  local search = {
    ft = vim.bo.filetype,
    ext = vim.fn.expand("%"):match(".+%.(.+)"),
  }

  for _, part in pairs(search) do
    local path = root .. "/" .. part
    if vim.uv.fs_stat(path) then
      return path
    end
  end

  vim.notify(
    "No template for " .. search.ft .. " or " .. search.ext,
    vim.log.levels.WARN
  )
  return nil
end

vim.keymap.set("n", "<leader>lt", function()
  local t = get_template()
  if not t then
    return
  end
  vim.cmd("0r " .. t)
end, { desc = "[L]oad [T]emplate" })

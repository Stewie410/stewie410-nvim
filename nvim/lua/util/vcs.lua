local M = {}

local function get_vcs_dir(name, file)
  file = file or vim.fn.expand("%")
  if file == nil then
    error("util.vcs: cannot expand filename")
  end

  local path = vim.fn.fnamemodify(file, ":p")
  while true do
    path = vim.fnamemodify(path, ":h")
    if vim.fn.isdirectory(path .. "/" .. name) then
      return path .. "/" .. name
    elseif path == "" or path == "/" then
      return ""
    end
  end
end

---Find nearest ".svn" directory, upwards
---@param file string? File to begin search; default to current
---@return string
function M.get_svn_dir(file)
  return get_vcs_dir(".svn", file)
end

---Find nearest ".git" directory, upwards
---@param file string? File to begin search; default to current
---@return string
function M.get_git_dir(file)
  return get_vcs_dir(".git", file)
end

return M

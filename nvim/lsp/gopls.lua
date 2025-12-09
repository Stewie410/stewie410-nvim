local cmd = "gopls"
if not vim.fn.executable("go") or not vim.fn.executable(cmd) then
  return {}
end

local M = {
  path = {
    stdlib = nil,
    modcache = nil,
  },
}

---@class godir_custom_args
---@field env string Go-Environment Variable name
---@field subdir string? Custom subdirectory
---@field callback fun(dir: string|nil)

---Locate go directory by go environment variable
---@param opts godir_custom_args
function M.find_godir(opts)
  local command = { "go", "env", opts.env }
  vim.system(command, { text = true }, function(out)
    local res = vim.trim(out.stdout or "")
    if out.code == 0 and res ~= "" then
      if opts.subdir and opts.subdir ~= "" then
        res = res .. opts.subdir
      end
      opts.callback(res)
    else
      local msg = "[gopls] identify %s dir cmd failed with code %d: %s\n%s"
      vim.schedule(function()
        vim.notify(msg:format(opts.env, out.code, vim.inspect(command), out.stderr))
      end)
      opts.callback(nil)
    end
  end)
end

---Locate stdlib path
---@return string?
function M.get_stdlib()
  if M.path.stdlib == nil or M.path.stdlib == "" then
    M.find_godir({
      env = "GOROOT",
      subdir = "/src",
      callback = function(d)
        if d then
          M.path.stdlib = d
        end
      end,
    })
  end
  return M.path.stdlib
end

---Locate modcache path
---@return string?
function M.get_modcache()
  if M.path.modcache == nil or M.path.modcache == "" then
    M.find_godir({
      env = "GOMODCACHE",
      callback = function(d)
        if d then
          M.path.modcache = d
        end
      end,
    })
  end
  return M.path.modcache
end

---Try find root directory from buf by stdlib or modcache
---Fallback to markers if defined
---@param bufnr number
---@param markers? string[] vim.lsp.Config.root_markers
---@return string?
function M.find_root(bufnr, markers)
  local fname = vim.api.nvim_buf_get_name(bufnr)

  for _, path in ipairs({ M.get_stdlib(), M.get_modcache() }) do
    if path and fname:sub(1, #path) == path then
      local clients = vim.lsp.get_clients({ name = "gopls" })
      if #clients > 0 then
        return clients[#clients].config.root_dir
      end
    end
  end

  for _, marker in ipairs(markers or {}) do
    local root = vim.fs.root(fname, marker)
    if root and root ~= "" then
      return root
    end
  end
end

return {
  cmd = { cmd },
  filetypes = {
    "go",
    "gomod",
    "gowork",
    "gotmpl",
  },
  root_dir = function(bufnr, on_dir)
    -- -- see: https://github.com/neovim/nvim-lspconfig/issues/804
    on_dir(M.find_root(bufnr, {
      "go.work",
      "go.mod",
      ".git",
      ".svn",
    }))
  end,
}

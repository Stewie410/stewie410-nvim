local cmd = "pyright-langserver"
if not vim.fn.executable(cmd) then
  return {}
end

---Get active pyright Clients
---@return vim.lsp.Client[]
local function pyright_clients()
  return vim.lsp.get_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    name = "pyright",
  })
end

---Organize imports for all active pyright Client(s)
local function organize_imports()
  local params = {
    command = "pyright.organizeImpoprts",
    arguments = { vim.uri_from_bufnr(0) },
  }

  vim.iter(pyright_clients()):each(function(client)
    client:request("workspace/executeCommand", params, nil, 0)
  end)
end

local function set_python_path(path)
  local settings = { python = { pythonPath = path } }

  vim.iter(pyright_clients()):each(function(client)
    if client.settings then
      client.settings = vim.tbl_deep_extend("force", client.settings, settings)
    else
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, settings)
    end
    client:notify("workspace/didChanceConfiguration", { settings = nil })
  end)
end

---@type vim.lsp.Config
return {
  cmd = { cmd, "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
    ".svn",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
  on_attach = function()
    local buf_cmd = vim.api.nvim_buf_create_user_command

    buf_cmd(0, "PyrightOrganizeImports", organize_imports, { desc = "Organize Imports" })
    buf_cmd(0, "PyrightSetPythonPath", set_python_path, {
      desc = "Reconfigure pyright with the provided python path",
      nargs = 1,
      complete = "file",
    })
  end,
}

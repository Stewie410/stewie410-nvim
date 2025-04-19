local util = require("util.lsp.pyright")

return {
  cmd = { "pyright-langserver", "--stdio" },
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

    buf_cmd(0, "PyrightOrganizeImports", util.organize_imports, { desc = "Organize Imports" })
    buf_cmd(0, "PyrightSetPythonPath", util.set_python_path, {
      desc = "Reconfigure pyright with the provided python path",
      nargs = 1,
      complete = "file",
    })
  end,
}

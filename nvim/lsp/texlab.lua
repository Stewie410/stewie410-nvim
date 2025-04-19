local util = require("util.lsp.texlab")

return {
  cmd = { "texlab" },
  filetypes = {
    "tex",
    "plaintex",
    "bib",
  },
  root_markers = {
    ".latexmkrc",
    ".texlabroot",
    "texlabroot",
    "Tectonic.toml",
    ".git",
    ".svn",
  },
  settings = {
    texlab = {
      rootDirectory = nil,
      build = {
        executable = "latexmk",
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        onSave = false,
        forwardSearchAfter = false,
      },
      forwardSearch = {
        executable = nil,
        args = {},
      },
      chktex = {
        onOpenAndSave = false,
        onEdit = false,
      },
      diagnosticsDelay = 300,
      latexFormatter = "latexindent",
      latexindent = {
        ["local"] = nil,
        modifyLineBreaks = false,
      },
      bibtexFormatter = "texlab",
      formatterLineLength = 80,
    },
  },
  on_attach = function()
    local buf_cmd = vim.api.nvim_buf_create_user_command

    buf_cmd(0, "TexlabBuild", util.client_with_fn(util.buf_build), {
      desc = "Build the current buffer",
    })
    buf_cmd(0, "TexlabForward", util.client_with_fn(util.buf_search), {
      desc = "Forward search from current position",
    })
    buf_cmd(0, "TexlabCancelBuild", util.client_with_fn(util.buf_cancel_build), {
      desc = "Cancel the current build",
    })
    buf_cmd(0, "TexlabDependencyGraph", util.client_with_fn(util.dependency_graph), {
      desc = "Show the dependency graph",
    })
    buf_cmd(0, "TexlabCleanArtifacts", util.client_with_fn(util.command_factory("Artifacts")), {
      desc = "Clean the aritfacts",
    })
    buf_cmd(0, "TexlabCleanAuxiliary", util.client_with_fn(util.command_factory("Auxiliary")), {
      desc = "Clean the auxiliary files",
    })
    buf_cmd(0, "TexlabFindEnvironments", util.client_with_fn(util.buf_find_envs), {
      desc = "Find the environments at current position",
    })
    buf_cmd(0, "TexlabChangeEnvironment", util.client_with_fn(util.buf_change_env), {
      desc = "Change the environment at current position",
    })
  end,
}

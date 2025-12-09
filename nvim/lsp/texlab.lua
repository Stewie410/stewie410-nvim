local cmd = "texlab"
if not vim.fn.executable(cmd) then
  return {}
end

---Get client positional params
---@param client vim.lsp.Client
---@return lsp.TextDocumentPositionParams
local function get_win_params(client)
  local winnr = vim.api.nvim_get_current_win()
  return vim.lsp.util.make_position_params(winnr, client.offset_encoding)
end

---Get client and function (?)
---@param callback fun(client: vim.lsp.Client, bufnr: integer):any?
---@return fun():any?
local function client_with_fn(callback)
  return function()
    local bufnr = vim.api.nvim_get_current_buf()
    local client = vim.lsp.get_clients({ bufnr = bufnr, name = "texlab" })[1]

    if not client then
      return vim.notify(("TeXLab client not found in buf[%d]"):format(bufnr), vim.log.levels.ERROR)
    end

    callback(client, bufnr)
  end
end

---Build document & notify status
---@param client vim.lsp.Client
---@param bufnr integer
local function buf_build(client, bufnr)
  local params = get_win_params(client)
  client:request("textDocument/build", params, function(err, result)
    if err then error(tostring(err)) end
    local status = { "Success", "Error", "Failire", "Cancelled" }
    vim.notify("Build " .. status[result.status + 1], vim.log.levels.INFO)
  end, bufnr)
end

---Forward search & notify status
---@param client vim.lsp.Client
---@param bufnr integer
local function buf_search(client, bufnr)
  local params = get_win_params(client)
  client:request("textDocument/forwardSearch", params, function(err, result)
    if err then error(tostring(err)) end
    local status = { "Success", "Error", "Failure", "Unconfigured" }
    vim.notify("Search " .. status[result.status + 1], vim.log.levels.INFO)
  end, bufnr)
end

---Cancel running build
---@param client vim.lsp.Client
---@param bufnr integer
local function buf_cancel_build(client, bufnr)
  return client:exec_cmd({ title = "cancel", command = "texlab.cancelBuild" }, { bufnr = bufnr })
end

---Generate dependency graph
---@param client vim.lsp.Client
local function dependency_graph(client)
  client:request("workspace/executeCommand", { command = "texlab.showDependencyGraph" }, function(err, result)
    if err then
      return vim.notify(err.code .. ": " .. err.message, vim.log.levels.ERROR)
    end
    vim.notify("The dependency graph has been generated:\n" .. result, vim.log.levels.INFO)
  end)
end

---command builder
---@param cmd string command name
---@return fun(client: vim.lsp.Client, bufnr: integer):any?
local function command_factory(cmd)
  local lookup = {
    Auxiliary = "texlab.cleanAuxiliary",
    Artifacts = "texlab.cleanArtifacts",
    CancelBuild = "textlab.cancelBuild",
  }

  return function(client, bufnr)
    local params = {
      title = "clean_" .. cmd,
      command = lookup[cmd],
      arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
    }

    return client:exec_cmd(params, { bufnr = bufnr }, function(err, _)
      if err then
        vim.notify(("Failed to clean %s files: %s"):format(cmd, err.message), vim.log.levels.ERROR)
      else
        vim.notify(cmd .. "executed successfully", vim.log.levels.INFO)
      end
    end)
  end
end

---Find environments & display in a floating window
---@param client vim.lsp.Client
---@param bufnr integer
local function buf_find_envs(client, bufnr)
  local params = {
    command = "texlab.findEnvironment",
    arguments = { get_win_params(client) },
  }

  client:request("workspace/executeCommand", params, function(err, result)
    if err then
      return vim.notify(err.code .. ": " .. err.message, vim.log.levels.ERROR)
    end

    local t = vim.iter(result):fold({ names = {}, max = 0 }, function(acc, env)
      table.insert(acc.names, string.rep(" ", #acc.names) .. env.name.text)
      acc.max = math.max(acc.max, #env.name.text)
      return acc
    end)

    vim.lsp.util.open_floating_preview(t.names, "", {
      height = #t.names,
      width = math.max(t.max + #t.names - 1, string.len("Environments")),
      focusable = false,
      focus = false,
      border = "single",
      title = "Environments",
    })
  end, bufnr)
end

---Change buffer environment
---@param client vim.lsp.Client
---@param bufnr integer
---@return any?
local function buf_change_env(client, bufnr)
  local new = vim.fn.input("New Environment Name: ")
  if not new or new == "" then
    return vim.notify("No environment name provided", vim.log.levels.WARN)
  end

  local winnr = vim.api.nvim_get_current_win()
  local pos = vim.api.nvim_win_get_cursor(winnr)
  return client:exec_cmd({
    title = "change_environment",
    command = "texlab.changeEnvironment",
    arguments = {
      {
        textDocument = { uri = vim.uri_from_bufnr(bufnr) },
        position = { line = pos[1] - 1, character = pos[2] },
        newName = tostring(new),
      },
    },
  }, { bufnr = bufnr })
end

---@type vim.lsp.Config
return {
  cmd = { cmd },
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

    buf_cmd(0, "TexlabBuild", client_with_fn(buf_build), {
      desc = "Build the current buffer",
    })
    buf_cmd(0, "TexlabForward", client_with_fn(buf_search), {
      desc = "Forward search from current position",
    })
    buf_cmd(0, "TexlabCancelBuild", client_with_fn(buf_cancel_build), {
      desc = "Cancel the current build",
    })
    buf_cmd(0, "TexlabDependencyGraph", client_with_fn(dependency_graph), {
      desc = "Show the dependency graph",
    })
    buf_cmd(0, "TexlabCleanArtifacts", client_with_fn(command_factory("Artifacts")), {
      desc = "Clean the aritfacts",
    })
    buf_cmd(0, "TexlabCleanAuxiliary", client_with_fn(command_factory("Auxiliary")), {
      desc = "Clean the auxiliary files",
    })
    buf_cmd(0, "TexlabFindEnvironments", client_with_fn(buf_find_envs), {
      desc = "Find the environments at current position",
    })
    buf_cmd(0, "TexlabChangeEnvironment", client_with_fn(buf_change_env), {
      desc = "Change the environment at current position",
    })
  end,
}

local M = {}

local function get_win_params(client)
  local win = vim.api.nvim_get_current_win()
  return vim.lsp.util.make_position_params(win, client.offset_encoding)
end

function M.client_with_fn(fn)
  return function()
    local bufnr = vim.api.nvim_get_current_buf()
    local client = vim.lsp.get_clients({ bufnr = bufnr, name = "texlab" })[1]

    if not client then
      return vim.notify(("texlab client not found in bufnr %d"):format(bufnr), vim.log.levels.ERROR)
    end
    fn(client, bufnr)
  end
end

function M.buf_build(client, bufnr)
  local params = get_win_params(client)

  client:request("textDocument/build", params, function(err, result)
    if err then
      error(tostring(err))
    end
    local status = {
      [0] = "Success",
      [1] = "Error",
      [2] = "Failure",
      [3] = "Cancelled",
    }
    vim.notify(("Build %s"):format(status[result.status]), vim.log.levels.INFO)
  end, bufnr)
end

function M.buf_search(client, bufnr)
  local params = get_win_params(client)

  client:request("textDocument/forwardSearch", params, function(err, result)
    if err then
      error(tostring(err))
    end
    local status = {
      [0] = "Success",
      [1] = "Error",
      [2] = "Failure",
      [3] = "Unconfigured",
    }
    vim.notify(("Search %s"):format(status[result.status]), vim.log.levels.INFO)
  end, bufnr)
end

function M.buf_cancel_build(client, bufnr)
  return client:exec_cmd({ title = "cancel", command = "texlab.cancelBuild" }, { bufnr = bufnr })
end

function M.dependency_graph(client)
  client:request("workspace/executeCommand", { command = "texlab.showDependencyGraph" }, function(err, result)
    if err then
      return vim.notify(("%d: %s"):format(err.code, err.message), vim.log.levels.ERROR)
    end
    vim.notify(("The dependency graph has been generated:\n%s"):format(result), vim.log.levels.INFO)
  end, 0)
end

function M.command_factory(cmd)
  local cmd_tbl = {
    Auxiliary = "texlab.cleanAuxiliary",
    Artifacts = "texlab.cleanArtifacts",
    CancelBuild = "texlab.cancelBuild",
  }

  return function(client, bufnr)
    return client:exec_cmd({
      title = ("clean_%s"):format(cmd),
      command = cmd_tbl[cmd],
      arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
    }, {
      bufnr = bufnr,
    }, function(err, _)
      if err then
        vim.notify(("Failed to clean %s files: %s"):format(cmd, err.message), vim.log.levels.ERROR)
      else
        vim.notify(("command %s executed successfully"):format(cmd), vim.log.levels.INFO)
      end
    end)
  end
end

function M.buf_find_envs(client, bufnr)
  client:request("workspace/executeCommand", {
    command = "texlab.findEnvironment",
    arguments = { get_win_params(client) },
  }, function(err, result)
    if err then
      return vim.notify(("%d: %s"):format(err.code, err.message), vim.log.levels.ERROR)
    end

    local env_names = {}
    local max_len = 1

    for _, env in ipairs(result) do
      table.insert(env_names, env.name.text)
      max_len = math.max(max_len, string.len(env.name.text))
    end

    for i, name in ipairs(env_names) do
      env_names[i] = ("%s%s"):format(string.rep(" ", i - 1), name)
    end

    vim.lsp.util.open_floating_preview(env_names, "", {
      height = #env_names,
      width = math.max((max_len + #env_names - 1), string.len("Environments")),
      focusable = false,
      focus = false,
      border = "single",
      title = "Environments",
    })
  end, bufnr)
end

function M.buf_change_env(client, bufnr)
  local new = vim.fn.input("Enter the new environment name: ")
  if not new or new == "" then
    return vim.notify("No environment name provided", vim.log.levels.WARN)
  end

  local pos = vim.api.nvim_win_get_cursor(0)
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

return M

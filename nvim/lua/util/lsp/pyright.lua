local M = {}

function M.organize_imports()
  local params = {
    command = "pyright.organizeImports",
    arguments = { vim.url_from_bufnr(0) },
  }

  local clients = vim.lsp.get_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    name = "pyright",
  })

  for _, client in ipairs(clients) do
    client:request("workspace/executeCommand", params, nil, 0)
  end
end

function M.set_python_path(path)
  local clients = vim.lsp.get_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    name = "pyright",
  })

  local settings = { python = { pythonPath = path } }

  for _, client in ipairs(clients) do
    if client.settings then
      client.settings = vim.tbl_deep_extend("force", client.settings, settings)
    else
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, settings)
    end
    client:notify("workspace/didChangeConfiguration", { settings = nil })
  end
end

return M

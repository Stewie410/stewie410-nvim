local M = {}

---@type lsp.ClientCapabilities
M.default = {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
    ---@diagnostic disable-next-line: missing-fields
    semanticTokens = {
      multilineTokenSupport = true,
    },
  },
  workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = false,
    },
  },
}

---Merge native capabilities & overrides
---@param capabilities lsp.ClientCapabilities?
---@return lsp.ClientCapabilities
function M.native(capabilities)
  local builtin = vim.lsp.protocol.make_client_capabilities()
  return vim.tbl_deep_extend("force", builtin, M.default, capabilities or {})
end

---Merge cmp-nvim-lsp capabilities & overrides
---@param capabilities lsp.ClientCapabilities?
---@return lsp.ClientCapabilities
function M.with_cmp(capabilities)
  local status_ok, cmp = pcall(require, "cmp_nvim_lsp")
  if not status_ok then
    vim.notify("LSP: Missing cmp-nvim-lsp: Fallback to native capabilities", vim.log.levels.WARN)
    return M.native(capabilities)
  end

  local builtin = cmp.default_capabilities()
  return vim.tbl_deep_extend("force", builtin, M.default, capabilities or {})
end

---Merge blink.cmp capabilities & overrides
---@param capabilities lsp.ClientCapabilities?
---@return lsp.ClientCapabilities
function M.with_blink(capabilities)
  capabilities = capabilities or {}
  local status_ok, blink = pcall(require, "blink.cmp")
  if not status_ok then
    vim.notify("LSP: Missing blink.cmp: fallback to native capabilities", vim.log.levels.WARN)
    return M.native(capabilities)
  end

  local builtin = blink.get_lsp_capabilities()
  return vim.tbl_deep_extend("force", builtin, M.default, capabilities or {})
end

return M

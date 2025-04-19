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
}

---Merge native capabilities & overrides
---@param capabilities lsp.ClientCapabilities?
---@return lsp.ClientCapabilities
function M.native(capabilities)
  capabilities = capabilities or {}
  return vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), M.default, capabilities or {})
end

---Merge cmp-nvim-lsp capabilities & overrides
---@param capabilities lsp.ClientCapabilities?
---@return lsp.ClientCapabilities
function M.with_cmp(capabilities)
  capabilities = capabilities or {}
  local status_ok, cmp = pcall(require, "cmp_nvim_lsp")
  if not status_ok then
    vim.notify("LSP: Missing cmp-nvim-lsp: Fallback to native capabilities", vim.log.levels.WARN)
    return M.native(capabilities)
  end
  return cmp.default_capabilities(capabilities)
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
  return blink.get_lsp_capabilities(capabilities)
end

return M

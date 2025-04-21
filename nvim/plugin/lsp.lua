local function get_servers(path)
  local map = {}

  for name, type in vim.fs.dir(path) do
    if type == "file" and vim.endswith(name, ".lua") then
      table.insert(map, name:match("^(.+)%.lua$"))
    end
  end

  return map
end

vim.lsp.config("*", {
  capabilities = require("util.lsp.capabilities").with_blink(),
  root_markers = {
    ".git",
    ".svn",
  },
})

-- TODO: validate servers installed
local servers = get_servers(vim.fn.stdpath("config") .. "/lsp")
vim.lsp.enable(servers)

local ag = vim.api.nvim_create_augroup("my.lsp", {})
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group = ag,
  callback = function(args)
    local bufnr = args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id),
      "Cannot determine LSP Client in buf[" .. bufnr .. "]")

    local map = vim.keymap.set

    -- TODO: Rethink my mappings...
    map("n", "grd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: Definition" })
    map("n", "grr", vim.lsp.buf.references, { buffer = bufnr, desc = "LSP: References" })
    map("n", "gri", vim.lsp.buf.implementation, { buffer = bufnr, desc = "LSP: Implementation" })
    map("n", "grD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: Declaration" })
    map("n", "<leader>td", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "LSP: Type Definitions" })
    map("n", "<leader>ds", vim.lsp.buf.document_symbol, { buffer = bufnr, desc = "LSP: Document Symbols" })
    map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { buffer = bufnr, desc = "LSP: Workspace Symbols" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code Action" })
    map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: Rename" })
    map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover Documentation" })

    vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"

    local supports = {
      cmp = client:supports_method("textDocument/completion"),
      wait = client:supports_method("textDocument/willSaveWaitUntil"),
      fmt = client:supports_method("textDocument/formatting"),
    }

    if not supports.wait and supports.fmt then
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        group = ag,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

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

    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, {
        buffer = bufnr,
        silent = true,
        noremap = true,
        desc = "LSP: " .. desc,
      })
    end

    local code_action = vim.lsp.buf
    if pcall(require, "tiny-code-action") then
      code_action = require("tiny-code-action")
    end

    -- TODO: Rethink my mappings...
    map("n", "grd", vim.lsp.buf.definition, "Definition")
    map("n", "grr", vim.lsp.buf.references, "References")
    map("n", "gri", vim.lsp.buf.implementation, "Implementation")
    map("n", "grD", vim.lsp.buf.declaration, "Declaration")
    map("n", "<leader>td", vim.lsp.buf.type_definition, "Type Definition")
    map("n", "<leader>ds", vim.lsp.buf.document_symbol, "Document Symbol")
    map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace Symbol")
    map("n", "<leader>ca", code_action.code_action, "Code Action")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    map("n", "K", vim.lsp.buf.hover, "Hover Documentation")

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

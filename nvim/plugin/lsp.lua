vim.lsp.config("*", {
  capabilities = require("util.lsp.capabilities").with_blink(),
  root_markers = {
    ".git",
    ".svn",
  },
})

local servers = {
  Windows_NT = {
    "powershell_es",
  },
  Linux = {
    "awk_ls",
    "bashls",
    "jqls",
  },
  any = {
    "texlab",
    "lemminx",
    "pyright",
    "html",
    "diagnosticls",
    "jsonls",
    "yamlls",
    "taplo",
    "vimls",
    "lua_ls",
    -- "emmylua_ls",
    "markdown_oxide",
    "docker_compose_language_server",
    "groovyls",
    "dockerls",
  },
}

vim.lsp.enable(servers.any)

local os = vim.uv.os_uname().sysname
if vim.tbl_contains(vim.tbl_keys(servers), os) then
  vim.lsp.enable(servers[os])
end

local ag = vim.api.nvim_create_augroup("my.lsp", {})
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group = ag,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    assert(client, ("Cannot determine LSP Client in buf[%d]"):format(args.buf))

    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, {
        buffer = args.buf,
        silent = true,
        noremap = true,
        desc = "LSP: " .. desc,
      })
    end

    local code_action = vim.lsp.buf
    if pcall(require, "tiny-code-action") then
      code_action = require("tiny-code-action")
    end

    map("n", "<leader>gd", vim.lsp.buf.definition, "Definition")
    map("n", "<leader>gr", vim.lsp.buf.references, "References")
    map("n", "<leader>gi", vim.lsp.buf.implementation, "Implementation")
    map("n", "<leader>gD", vim.lsp.buf.declaration, "Declaration")
    map("n", "<leader>gt", vim.lsp.buf.type_definition, "Type Definition")
    map("n", "<leader>gs", vim.lsp.buf.document_symbol, "Document Symbol")
    map("n", "<leader>gw", vim.lsp.buf.workspace_symbol, "Workspace Symbol")
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
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end

    -- TODO:  find a more sane way of doing this
    vim.api.nvim_buf_create_user_command(args.buf, "LspLog", function()
      vim.cmd.split(vim.lsp.log.get_filename())
    end, { desc = "Open lsp.log in a :split" })
  end,
})

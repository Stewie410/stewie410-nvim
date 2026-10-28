vim.lsp.config("*", {
  capabilities = require("util.lsp.capabilities").native(),
  root_markers = {
    ".git",
    ".svn",
  },
})

vim.lsp.enable({
  "awk_ls",
  -- "bashls",
  "shuck",
  -- "shell-lsp",
  "jqls",
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
  "gopls",
  "golangci_lint_ls",
  "systemd_lsp",
  "ls_lsp",
})

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group = vim.api.nvim_create_augroup("lsp.attach", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    assert(client, ("Cannot determine LSP Client in buf[%d]"):format(ev.buf))

    vim.o.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.lsp.codelens.enable(true)

    local supports = {
      cmp = client:supports_method("textDocument/completion"),
      wait = client:supports_method("textDocument/willSaveWaitUntil"),
      fmt = client:supports_method("textDocument/formatting"),
    }

    if not supports.wait and supports.fmt then
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        group = vim.api.nvim_create_augroup("lsp.format", {}),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

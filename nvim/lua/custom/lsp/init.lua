-- require("neodev").setup()
require("lazydev").setup({
  library = {
    "lazy.nvim",
    { path = "luvit-meta/library", words = { "vim%.uv" } },
  },
})

local capabilities = require("custom.lsp.capabilities")
local lspconfig = require("lspconfig")

local servers = {
  -- LSP
  ansiblels = true,
  awk_ls = true,
  bashls = true,
  clangd = true,
  cssls = true,
  diagnosticls = true,
  docker_compose_language_service = true,
  dockerls = true,
  emmet_language_server = true,
  gopls = true,
  groovyls = {
    cmd = {
      "java",
      "-jar",
      vim.fn.expand(
        "~/git/groovy-language-server/build/libs/groovy-language-server-all.jar"
      ),
    },
  },
  html = true,
  jdtls = true,
  jqls = true,
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  lemminx = true,
  lua_ls = true,
  ltex = true,
  markdown_oxide = true,
  powershell_es = {
    bundle_path = vim.fn.stdpath("data")
      .. "/mason/packages/powershell-editor-services",
    filetypes = {
      "ps1",
      "psm1",
      "psd1",
      "PowerShell",
    },
    settings = {
      powershell = {
        codeFormatting = {
          Preset = "OTBS",
        },
      },
    },
  },
  puppet = true,
  pyright = true,
  taplo = true,
  tsserver = true,
  vimls = true,
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  },
}

local servers_to_install = vim.tbl_filter(function(key)
  local t = servers[key]
  if type(t) == "table" then
    return not t.manual_install
  else
    return t
  end
end, vim.tbl_keys(servers))

require("mason").setup()
local ensure_installed = {
  "stylua",
  "lua_ls",
}

vim.list_extend(ensure_installed, servers_to_install)
require("mason-tool-installer").setup({
  ensure_installed = ensure_installed,
})

for name, config in pairs(servers) do
  if config == true then
    config = {}
  end
  config = vim.tbl_deep_extend("force", {}, {
    capabilities = capabilities,
  }, config)

  lspconfig[name].setup(config)
end

require("custom.lsp.ahk2").setup()

local disable_semantic_tokens = { lua = true }

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  callback = function(args)
    local tsb = require("telescope.builtin")
    local bufnr = args.buf

    local client = assert(
      vim.lsp.get_client_by_id(args.data.client_id),
      "must have valid client"
    )

    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, {
        desc = desc,
        buffer = 0,
      })
    end

    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    map("gd", tsb.lsp_definitions, "[G]oto [D]efinition")
    map("gr", tsb.lsp_references, "[G]oto [R]efences")
    map("gI", tsb.lsp_implementations, "[G]oto [I]mplementations")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("<leader>D", tsb.lsp_type_definitions, "Goto Type [D]finitions")
    map("<leader>ds", tsb.lsp_document_symbols, "Goto [D]ocument [S]ymbols")
    map("<leader><ws", tsb.lsp_workspace_symbols, "Goto [W]orkspace [S]ymbols")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("K", vim.lsp.buf.hover, "Hover Documentation")

    local filetype = vim.bo[bufnr].filetype
    if disable_semantic_tokens[filetype] then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

-- Autoformat setup
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
  },
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function(args)
    require("conform").format({
      bufnr = args.buf,
      lsp_fallback = true,
      quiet = true,
    })
  end,
})

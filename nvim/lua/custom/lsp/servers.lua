local M = {}

local capabilities = require("custom.lsp.capabilities")
local lspconfig = require("lspconfig")

local linux_only = {
  awk_ls = {},
  bashls = {},
  -- clangd = {},
  -- gopls = {},
  jqls = {},
}

local servers = {
  -- ansiblels = {},
  cssls = {},
  diagnosticls = {},
  docker_compose_language_service = {},
  dockerls = {},
  -- emmet_language_server = {},
  html = {},
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  lemminx = {},
  lua_ls = {},
  -- ltex = {},
  markdown_oxide = {},
  -- puppet = {},
  pyright = {},
  taplo = {},
  -- tsserver = {},
  vimls = {},
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

function M.setup()
  local sysname = vim.uv.os_uname().sysname

  -- Skip LSPs I'm unlikely to need outside of Linux
  if sysname == "Linux" then
    servers = vim.tbl_extend("force", servers, linux_only)
  end

  -- Include AHKv2 LSP on Windows machines, if available
  if sysname == "Windows_NT" then
    local ahk = require("custom.lsp.ahk2")
    if ahk.server_installed() then
      ahk.setup()
    end
  end

  local ensure_installed = {
    "stylua",
    "lua_ls",
    "groovy-language-server",
    "powershell-editor-services",
  }

  -- Mason packages
  vim.list_extend(ensure_installed, vim.tbl_keys(servers))
  require("mason-tool-installer").setup({
    ensure_installed = ensure_installed,
  })

  -- lspconfig
  local basic_config = {
    capabilities = capabilities,
  }

  for name, config in pairs(servers) do
    config = vim.tbl_deep_extend("force", {}, basic_config, config)
    lspconfig[name].setup(config)
  end

  local mason_path = vim.fn.stdpath("data") .. "/mason/packages"

  lspconfig.groovyls.setup(vim.tbl_deep_extend("force", basic_config, {
    cmd = {
      mason_path .. "/groovy-language-server/groovy-language-server",
    },
  }))

  lspconfig.powershell_es.setup(vim.tbl_deep_extend("force", basic_config, {
    bundle_path = mason_path .. "/powershell-editor-services",
    filetypes = {
      "ps1",
      "psm1",
      "psd1",
    },
    settings = {
      powershell = {
        codeFormatting = {
          Preset = "OTBS",
        },
      },
    },
  }))
end

return M

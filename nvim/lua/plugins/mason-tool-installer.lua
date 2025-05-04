local available = require("util.lsp.servers").available()

return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = {
      { "williamboman/mason.nvim",           lazy = false, opts = {} },
      { "williamboman/mason-lspconfig.nvim", lazy = false, opts = {} },
    },
    opts = {
      ensure_installed = available,
      auto_update = true,
      run_on_start = true,
    },
  },
}

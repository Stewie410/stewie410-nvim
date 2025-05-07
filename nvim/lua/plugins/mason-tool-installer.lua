local available = require("util.lsp.servers").available()

-- TODO write my own tool-installer, based on mason v2.x
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = {
      {
        "mason-org/mason.nvim",
        version = "1.x",
        lazy = false,
        opts = {},
      },
      {
        "mason-org/mason-lspconfig.nvim",
        version = "1.x",
        lazy = false,
        opts = {},
      },
    },
    opts = {
      ensure_installed = available,
      auto_update = true,
      run_on_start = true,
    },
  },
}

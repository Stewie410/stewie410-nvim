return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "folke/lazydev.nvim",
      "Bilal2453/luvit-meta",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "stevearc/conform.nvim",
      "b0o/SchemaStore.nvim",
      "ray-x/lsp_signature.nvim",
    },
    config = function()
      require("custom.lsp")
    end,
  },
}

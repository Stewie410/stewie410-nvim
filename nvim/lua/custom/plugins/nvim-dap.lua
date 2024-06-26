return {
  {
    "mfussenegger/nvim-dap",
    event = "LspAttach",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "jbyuki/one-small-step-for-vimkind",
    },
    config = function()
      require("custom.dap")
    end,
  },
}

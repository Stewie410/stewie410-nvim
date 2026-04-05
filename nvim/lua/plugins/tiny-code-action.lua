vim.pack.add({
  "https://github.com/rachartier/tiny-code-action.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/folke/snacks.nvim",
})

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  callback = function()
    require("tiny-code-action").setup({
      picker = { "snacks" },
    })
  end,
  desc = "Lazy-Load tiny-code-action",
})

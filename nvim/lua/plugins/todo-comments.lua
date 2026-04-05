vim.pack.add({
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    require("todo-comments").setup({
      signs = false,
    })
  end,
  desc = "LazyLoad: todo-comments.nvim",
})

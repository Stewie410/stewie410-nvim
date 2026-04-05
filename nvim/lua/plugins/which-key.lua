vim.pack.add({
  "https://github.com/folke/which-key.nvim",
  "https://github.com/echasnovski/mini.icons",
  "https://github.com/nvim-tree/nvim-web-devicons",
})

---@diagnostic disable-next-line: missing-fields
require("which-key").setup({
  preset = "helix",
  spec = {
    { "<leader>c", group = "[C]ode" },
    { "<leader>d", group = "[D]ocument" },
    { "<leader>f", group = "[F]ind" },
    { "<leader>r", group = "[R]ename" },
    { "<leader>s", group = "[S]urround" },
    { "<leader>w", group = "[W]orkspace" },
    { "<leader>t", group = "[T]oggle" },
  }
})

vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer local keymaps" })

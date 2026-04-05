vim.pack.add({
  "https://github.com/Stewie410/boiler.nvim",
  "https://github.com/Grub4K/glib.nvim",
  "https://github.com/folke/snacks.nvim",
})

require("boiler").setup({
  picker = "snacks",
  paths = {
    os.getenv("XDG_CONFIG_HOME") .. "/boilerplate",
    os.getenv("XDG_CONFIG_HOME") .. "/private/boilerplate",
  },
})

if not vim.g.vim_pack_init.boiler == 1 then
  vim.keymap.set("n", "<leader>bb", function()
    require("boiler").pick(vim.bo.filetype)
  end, { desc = "Boiler: Select by Filetype" })

  vim.keymap.set("n", "<leader>ba", function()
    require("boiler").pick()
  end, { desc = "Boiler: Select from Any" })

  vim.g.vim_pack_init.boiler = 1
end

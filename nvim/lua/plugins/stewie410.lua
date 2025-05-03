return {
  {
    "Stewie410/boiler.nvim",
    dev = true,
    dependencies = {
      "Grub4K/glib.nvim",
      "folke/snacks.nvim",
    },
    cmd = {
      "Boiler",
      "BoilerAll",
    },
    keys = {
      { "<leader>bb", function() require("boiler").pick(vim.bo.filetype) end, desc = "Boiler: Select by Filetype" },
      { "<leader>ba", function() require("boiler").pick() end,                desc = "Boiler: Select Any" },
    },
    opts = {
      picker = "snacks",
      paths = {
        os.getenv("XDG_CONFIG_HOME") .. "/boilerplate",
      },
    },
  },
}

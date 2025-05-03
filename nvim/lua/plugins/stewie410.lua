return {
  {
    "Stewie410/lipsum-nvim",
    dev = true,
    lazy = false,
    cmd = {
      "LipsumWord",
      "LipsumLine",
      "LipsumParagraph",
    },
    opts = {},
  },
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

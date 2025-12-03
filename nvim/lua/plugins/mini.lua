return {
  -- text editing
  {
    "nvim-mini/mini.ai",
    version = "*",
    lazy = false,
    opts = {},
  },
  {
    "nvim-mini/mini.align",
    version = "*",
    lazy = false,
    opts = {},
  },
  {
    "nvim-mini/mini.move",
    version = "*",
    lazy = false,
    opts = {},
  },
  {
    "nvim-mini/mini.operators",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-mini/mini.pairs",
    version = "*",
    lazy = false,
    opts = {},
  },
  {
    "nvim-mini/mini.splitjoin",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-mini/mini.surround",
    version = "*",
    lazy = false,
    opts = {},
  },

  -- general workflow
  {
    "nvim-mini/mini.bracketed",
    version = "*",
    lazy = false,
    opts = {},
  },
  {
    "nvim-mini/mini.jump",
    version = "*",
    lazy = false,
    opts = {},
  },

  -- appearance
  {
    "nvim-mini/mini.cursorword",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-mini/mini.hipatterns",
    version = "*",
    event = "VeryLazy",
    config = function()
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
  {
    "nvim-mini/mini.statusline",
    version = "*",
    lazy = false,
    opts = {},
  },
}

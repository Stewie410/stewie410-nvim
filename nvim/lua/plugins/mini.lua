return {
  -- text editing
  {
    "echasnovski/mini.ai",
    version = "*",
    lazy = false,
    opts = {
      n_lines = 500,
    },
  },
  {
    "echasnovski/mini.comment",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.operators",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.pairs",
    version = "*",
    lazy = false,
    opts = {},
  },
  {
    "echasnovski/mini.splitjoin",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    lazy = false,
    opts = {},
  },

  -- general workflow
  {
    "echasnovski/mini.bracketed",
    version = "*",
    lazy = false,
    opts = {},
  },
  {
    "echasnovski/mini.jump",
    version = "*",
    lazy = false,
    opts = {},
  },

  -- appearance
  {
    "echasnovski/mini.cursorword",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.hipatterns",
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
    "echasnovski/mini.statusline",
    version = "*",
    lazy = false,
    opts = {},
  },
}

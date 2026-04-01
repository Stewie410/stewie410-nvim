vim.pack.add({
  "https://github.com/nvim-mini/mini.ai",
  "https://github.com/nvim-mini/mini.align",
  "https://github.com/nvim-mini/mini.move",
  "https://github.com/nvim-mini/mini.operators",
  "https://github.com/nvim-mini/mini.pairs",
  "https://github.com/nvim-mini/mini.splitjoin",
  "https://github.com/nvim-mini/mini.surround",

  "https://github.com/nvim-mini/mini.bracketed",
  "https://github.com/nvim-mini/mini.jump",

  "https://github.com/nvim-mini/mini.cursorword",
  "https://github.com/nvim-mini/mini.hipatterns",
  "https://github.com/nvim-mini/mini.statusline",
})

-- text editing
require("mini.ai").setup()
require("mini.align").setup()
require("mini.move").setup()
require("mini.operators").setup()
require("mini.pairs").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()

-- dx
require("mini.bracketed").setup()
require("mini.jump").setup()

-- ux
require("mini.cursorword").setup()
require("mini.hipatterns").setup({
  highlighters = {
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
  },
})
require("mini.statusline").setup()

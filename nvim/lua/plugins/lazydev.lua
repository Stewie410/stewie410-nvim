vim.pack.add({
  "https://github.com/folke/lazydev.nvim",
  "https://githun.com/gonstoll/wezterm-types",
})

local M = {}

function M.setup()
  require("lazydev").setup({
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "wezterm-types",      mods = { "wezterm" } },
    },
  })
end

return M

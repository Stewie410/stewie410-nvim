return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      local ig = "which_key_ignore"

      wk.setup()
      wk.register({
        ["<leader>c"] = { name = "[C]ode", _ = ig },
        ["<leader>d"] = { name = "[D]ocument", _ = ig },
        ["<leader>f"] = { name = "[F]ind", _ = ig },
        ["<leader>r"] = { name = "[R]ename", _ = ig },
        ["<leader>s"] = { name = "[S]urround", _ = ig },
        ["<leader>w"] = { name = "[W]orkspace", _ = ig },
        ["<leader>t"] = { name = "[T]oggle", _ = ig },
      })
    end,
  },
}

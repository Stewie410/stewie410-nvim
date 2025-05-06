return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    init = function(plugin)
      -- https://github.com/LazyVim/LazyVim/blob/12818a6cb499456f4903c5d8e68af43753ebc869/lua/lazyvim/plugins/treesitter.lua#L22
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      ensure_installed = "all",
      auto_install = true,
    },
    config = function(_, opts)
      local configs = require("nvim-treesitter.configs")
      configs.setup(opts)
    end,
  },
}

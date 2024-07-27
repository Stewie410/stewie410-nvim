return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    lazy = false,
    init = function(plugin)
      -- https://github.com/LazyVim/LazyVim/blob/12818a6cb499456f4903c5d8e68af43753ebc869/lua/lazyvim/plugins/treesitter.lua#L22
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = {
      "TSUpdateSync",
      "TSUpdate",
      "TSInstall",
    },
    opts_extend = { "ensure_installed" },
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      ensure_installed = {
        "awk",
        "bash",
        "bibtex",
        "c",
        "c_sharp",
        "cmake",
        -- "comment",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gpg",
        "graphql",
        "groovy",
        "html",
        "hyprlang",
        "ini",
        "javascript",
        "jq",
        "jsdoc",
        "json",
        "jsonc",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "luau",
        "make",
        "markdown",
        "markdown_inline",
        "nginx",
        "nix",
        "passwd",
        "powershell",
        "printf",
        "properties",
        "psv",
        "python",
        "query",
        "readline",
        "regex",
        "sql",
        "ssh_config",
        "terraform",
        "tmux",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "zig",
      },
      auto_install = true,
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        opts.ensure_installed =
          require("util.list").dedup(opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}

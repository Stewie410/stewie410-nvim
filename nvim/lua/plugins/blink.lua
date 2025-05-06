return {
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = {
      { "saghen/blink.compat", version = "*" },
      "rafamadriz/friendly-snippets",
      "mikavilpas/blink-ripgrep.nvim",
      "folke/snacks.nvim",
      "moyiz/blink-emoji.nvim",
      "MahanRahmati/blink-nerdfont.nvim",
      -- TODO: find/write a blink-native alternative
      -- "hrsh7th/cmp-cmdline",
      -- "hrsh7th/cmp-calc",
      -- "kdheepak/cmp-latex-symbols",
    },
    version = "1.*",
    opts = {
      appearance = {
        -- NOTE: will be removed in a future release?
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
        kind_icons = {
          Text = "",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",

          Field = "󰇽",
          Variable = "󰂡",
          Property = "󰜢",

          Class = "󰠱",
          Interface = "",
          Struct = "",
          Module = "",

          Unit = "",
          Value = "󰎠",
          Enum = "",
          EnumMember = "",

          Keyword = "󰌋",
          Constant = "󰏿",

          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "",
          Folder = "󰉋",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "󰅲",
        },
      },
      completion = {
        menu = {
          border = "single",
        },
        trigger = {
          show_on_trigger_character = true,
        },
      },
      keymap = {
        preset = "default",
        ["<C-y>"] = {},
        -- https://cmp.saghen.dev/configuration/keymap.html#super-tab
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
      },
      sources = {
        default = {
          "lazydev",
          "lsp",
          "path",
          "snippets",
          "omni",
          "buffer",
          "ripgrep",
          "emoji",
          "nerdfont",
          "cmdline",
        },
        providers = {
          snippets = {
            score_offset = 50,
            opts = {
              search_paths = {
                os.getenv("XDG_CONFIG_HOME") .. "/snippets",
                os.getenv("XDG_CONFIG_HOME") .. "/private/snippets",
                vim.fn.stdpath("data") .. "/lazy/friendly-snippets",
                vim.fn.stdpath("config") .. "/snippets",
              },
            },
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          ripgrep = {
            name = "Ripgrep",
            module = "blink-ripgrep",
            opts = {
              project_root_marker = { ".git", ".svn" },
              search_casing = "--smart-case",
            },
          },
          emoji = {
            name = "Emoji",
            module = "blink-emoji",
            score_offset = 15,
            opts = { insert = true },
          },
          nerdfont = {
            name = "Nerd Fonts",
            module = "blink-nerdfont",
            score_offset = 20,
            opts = { insert = true },
          },
          buffer = {
            score_offset = 0,
          },
        },
      },
      -- TODO:return to 'prefer_rust' at some point
      fuzzy = { implementation = "lua" },
      cmdline = {
        keymap = {
          preset = "cmdline",
          ["<Tab>"] = { "show", "accept" },
        },
        completion = {
          menu = {
            auto_show = function(ctx)
              return vim.fn.getcmdtype() == ":"
            end,
          },
        },
      },
      -- NOTE handled by noice.nvim, apparently
      -- signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
  },
}

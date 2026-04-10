-- plugins {{{
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/Grub4K/glib.nvim",
  "https://github.com/b0o/SchemaStore.nvim",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-tree/nvim-web-devicons",

  { src = "https://github.com/saghen/blink.cmp",    branch = "v1" },
  { src = "https://github.com/saghen/blink.compat", branch = "v2" },
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/mikavilpas/blink-ripgrep.nvim",

  "https://github.com/alker0/chezmoi.vim",
  "https://github.com/Shatur/neovim-ayu",
  "https://github.com/numToStr/Comment.nvim",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/folke/which-key.nvim",

  "https://github.com/folke/lazydev.nvim",
  "https://github.com/gonstoll/wezterm-types",
  "https://github.com/nvim-neotest/neotest",
  "https://github.com/nvim-neotest/nvim-nio",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
  "https://github.com/Stewie410/boiler.nvim",
  "https://github.com/rachartier/tiny-code-action.nvim",
  "https://github.com/folke/ts-comments.nvim",

  "https://github.com/tpope/vim-fugitive",
  "https://github.com/lewis6991/gitsigns.nvim",

  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/folke/snacks.nvim",
})
-- }}}

-- neovim-ayu {{{
require("ayu").setup({ mirage = false, terminal = true })
vim.cmd.colorscheme("ayu")
-- }}}

-- blink.cmp {{{
vim.api.nvim_create_autocmd({ "PackChangedPre" }, {
  callback = function(ev)
    local name, kind = ev.data.name, ev.data.kind
    if name == "blink.cmp" and (kind == "install" or kind == "update") then
      vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path })
    end
  end,
  desc = "Build blink.cmp",
})

require("blink.cmp").setup({
  appearance = {
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
          backend = {
            ripgrep = {
              search_casing = "--smart-case",
            },
          },
        },
      },
      buffer = {
        score_offset = 0,
      },
    },
  },
  fuzzy = {
    -- TODO: fix fuzzy_rust?
    implementation = "lua",
  },
  cmdline = {
    keymap = {
      preset = "cmdline",
      ["<Tab>"] = { "show", "accept" },
    },
    completion = {
      menu = {
        ---@diagnostic disable-next-line: unused-local
        auto_show = function(ctx)
          return vim.fn.getcmdtype() == ":"
        end,
      },
    },
  },
})
-- }}}

-- chezmoi.vim {{{
vim.g["chezmoi#use_tmp_buffer"] = true
-- }}}

-- boiler.nvim {{{
local boiler = require("boiler")
boiler.setup({
  picker = "snacks",
  paths = {
    os.getenv("XDG_CONFIG_HOME") .. "/boilerplate",
    os.getenv("XDG_CONFIG_HOME") .. "/private/boilerplate",
  },
})

vim.keymap.set("n", "<leader>bb", function() boiler.pick(vim.bo.filetype) end, {
  desc = "Boiler: Select from FT",
})
vim.keymap.set("n", "<leader>ba", function() boiler.pick() end, {
  desc = "Boiler: Select from Any",
})
-- }}}

-- Comment.nvim {{{
require("Comment").setup()
-- }}}

-- fidget.nvim {{{
require("fidget").setup({})
-- }}}

-- gitsigns {{{
require("gitsigns").setup()
-- }}}

-- neotest {{{
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "lua" },
  callback = function()
    ---@diagnostic disable-next-line: missing-parameter, missing-fields
    require("neotest").setup({})
  end,
})
-- }}}

-- lazydev {{{
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "lua" },
  callback = function()
    ---@diagnostic disable-next-line: missing-fields
    require("lazydev").setup({
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "wezter-types",       mods = { "wezterm" } },
      },
    })
  end,
})
-- }}}

-- nvim-treesitter {{{
vim.api.nvim_create_autocmd({ "PackChanged" }, {
  callback = function(ev)
    local name, kind = ev.data.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
  desc = "Auto-Update TS Parsers",
})

require("nvim-treesitter").install({
  "bash",
  "comment",
  "csv",
  "diff",
  "dockerfile",
  "editorconfig",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "go",
  "gomod",
  "gosum",
  "gotmpl",
  "groovy",
  "ini",
  "java",
  "javadoc",
  "javascript",
  "jq",
  "jsdoc",
  "json",
  "lua",
  "luadoc",
  "luap",
  "luau",
  "make",
  "markdown",
  "markdown_inline",
  "powershell",
  "printf",
  "promql",
  "properties",
  "python",
  "regex",
  "ssh_config",
  "tmux",
  "todotxt",
  "toml",
  "tsv",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
  "zsh",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "sh",
    "comment",
    "csv",
    "diff",
    "dockerfile",
    "editorconfig",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "groovy",
    "ini",
    "java",
    "javadoc",
    "javascript",
    "jq",
    "jsdoc",
    "json",
    "lua",
    "luadoc",
    "luap",
    "luau",
    "make",
    "markdown",
    "markdown_inline",
    "powershell",
    "printf",
    "promql",
    "properties",
    "python",
    "regex",
    "ssh_config",
    "tmux",
    "todotxt",
    "toml",
    "tsv",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
    "zsh",
  },
  callback = function()
    -- highlight
    vim.treesitter.start()

    -- fold
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[0][0].foldmethod = "expr"

    -- indent
    -- WARN: experimental
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
  desc = "nvim-treesitter",
})
-- }}}

-- mini.nvim {{{
require("mini.ai").setup()
require("mini.align").setup()
require("mini.bracketed").setup()
require("mini.cursorword").setup()
require("mini.jump").setup()
require("mini.move").setup()
require("mini.operators").setup()
require("mini.pairs").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()
require("mini.statusline").setup()

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  hilighters = {
    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack  = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
    todo  = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
    note  = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
  },
  hex_color = hipatterns.gen_highlighter.hex_color(),
})
-- }}}

-- snacks.nvim {{{
require("snacks").setup({
  bigfile = { enabled = true },
  explorer = { enabled = true },
  git = { enabled = true },
  indent = {
    enabled = true,
    animate = { enabled = false },
    scope = { enabled = true },
  },
  input = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  picker = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  words = { enabled = true },
})

vim.api.nvim_create_autocmd({ "User" }, {
  callback = function()
    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>uc")
    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
    Snacks.toggle.diagnostics():map("<leader>ud")
    Snacks.toggle.line_number():map("<leader>ul")
    Snacks.toggle.option(
      "conceallevel",
      { off = "light", on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
    ):map("<leader>uC")
    Snacks.toggle.treesitter():map("<leader>uT")
    Snacks.toggle.option(
      "background",
      { off = "light", on = "dark", name = "Dark Background" }
    ):map("<leader>ub")
    Snacks.toggle.inlay_hints():map("<leader>uh")
    Snacks.toggle.indent():map("<leader>ug")
    Snacks.toggle.dim():map("<leader>uD")
  end,
  desc = "snacks.nvim init"
})

vim.keymap.set("n", "<C-b>", function() Snacks.explorer() end, { desc = "Explorer" })
vim.keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep Buffers" })
vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "[N]otifications" })
vim.keymap.set("n", "<leader>d", function() Snacks.picker.diagnostics() end, { desc = "[D]iagnostics" })
vim.keymap.set("n", "<leader>D", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer [D]iagnostics" })
vim.keymap.set("n", "<leader>q", function() Snacks.picker.qflist() end, { desc = "[Q]uickfix List" })
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "[F]ind [F]iles" })

-- vim.key.amp.set("n", "<leader>gf", function() Snacks.picker.git_files() end, { desc = "[G]it [F]iles" })
-- vim.key.amp.set("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "[G]it [B]ranches" })
-- vim.key.amp.set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "[G]it [L]og" })
-- vim.key.amp.set("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "[G]it log [L]ine" })
-- vim.key.amp.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "[G]it [S]tatus" })
-- vim.key.amp.set("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "[G]it [S]tash" })
-- vim.key.amp.set("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "[G]it [D]iff" })
-- vim.key.amp.set("n", "<leader>gB", function() Snacks.gitbrowse() end, { desc = "[G]it [B]rowse" })

-- vim.keymap.set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "[S]earch [B]uffer" })
-- vim.keymap.set({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "[S]earch [W]ords" })
-- vim.keymap.set("n", "<leader>sr", function() Snacks.picker.registers() end, { desc = "[S]earch [R]egisters" })
-- vim.keymap.set("n", "<leader>sh", function() Snacks.picker.search_history() end, { desc = "[S]earch [H]istory" })
-- vim.keymap.set("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "[S]earch [A]utocmds" })
vim.keymap.set("n", "<leader>sc", function() Snacks.picker.commands() end, { desc = "[S]each [C]ommands" })
vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "[S]earch [H]elp" })
-- vim.keymap.set("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "[S]earch [H]ighlights" })
vim.keymap.set("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "[S]earch [I]cons" })
vim.keymap.set("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "[S]each [J]umps" })
vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "[S]earch [K]eymaps" })
-- vim.keymap.set("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "[S]each [L]ocation List" })
vim.keymap.set("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "[S]earch [M]arks" })
-- vim.keymap.set("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "[S]earch [M]anpages" })
-- vim.keymap.set("n", "<leader>sp", function() Snacks.picker.lazy() end, { desc = "[S]each [P]lugins" })
-- vim.keymap.set("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "[S]earch [U]ndo" })

vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "[F]ind [B]uffers" })
-- vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "[F]ind [P]rojects" })
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "[F]ind [R]ecent" })

vim.keymap.set("n", "<leader>rf", function() Snacks.rename.rename_file() end, { desc = "[R]ename [F]ile" })
vim.keymap.set("n", "<leader>dn", function() Snacks.notifier.hide() end, { desc = "[D]ismiss [N]otifier" })
-- vim.keymap.set({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Reference: Prev" } })
-- vim.keymap.set({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Reference: Next" })
-- }}}

-- tiny-code-action.nvim {{{
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  callback = function()
    require("tiny-code-action").setup({
      picker = { "snacks" },
    })
    local tca = require("tiny-code-action")
    tca.setup({
      picker = { "snacks" },
    })

    vim.keymap.set("n", "<leader>ca", tca.code_action, { desc = "LSP: Code Action", remap = true })
  end,
})
-- }}}

-- ts-comments.nvim {{{
require("ts-comments").setup()
-- }}}

-- which-key.nvim {{{
local which = require("which-key")
---@diagnostic disable-next-line: missing-fields
which.setup({
  preset = "helix",
  spec = {
    { "<leader>c", group = "[C]ode" },
    { "<leader>d", group = "[D]ocument" },
    { "<leader>f", group = "[F]ind" },
    { "<leader>r", group = "[R]ename" },
    { "<leader>s", group = "[S]urround" },
    { "<leader>w", group = "[W]orkspace" },
    { "<leader>t", group = "[T]oggle" },
  }
})

vim.keymap.set("n", "<leader>?", function() which.show({ global = false }) end, { desc = "Buffer Keymaps" })
-- }}}

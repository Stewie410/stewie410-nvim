vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

-- local lspkind = require("lspkind")
-- lspkind.init({})
local lsp_kind = require("custom.cmp.kind")

local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    expandable_indicator = true,
    fields = { "abbr", "kind", "menu" },
    format = function(entry, vim_item)
      return lsp_kind.format(entry, vim_item)
    end,
  },
  view = {
    entries = {
      name = "custom",
      selection_order = "near_cursor",
    },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-1),
    ["<C-f>"] = cmp.mapping.scroll_docs(1),
    ["<C-q>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "buffer" },
    { name = "luasnip" },
    { name = "emoji" },
    { name = "calc" },
    {
      name = "omni",
      option = {
        disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" },
      },
    },
    {
      name = "latex_symbols",
      option = {
        strategy = 2,
      },
    },
    {
      name = "lazydev",
      group_index = 0,
    },
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
  ---@diagnostic disable-next-line: missing-fields
  matching = {
    disallow_symbol_nonprefix_matching = false,
  },
})

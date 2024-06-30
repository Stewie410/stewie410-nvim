local ls = require("luasnip")
local map = function(keys, func, desc)
  vim.keymap.set({ "i", "s" }, keys, func, {
    silent = true,
    desc = "LuaSnip: " .. desc,
  })
end

ls.setup({
  region_check_events = "InsertEnter",
})

ls.config.set_config({
  history = true,
  enable_autosnippets = true,
  -- store_selection_keys = "<Tab>",
})

-- DEBUG
ls.log.set_loglevel("info")

-- load luasnip snippet files
require("luasnip.loaders.from_lua").load({
  paths = {
    vim.fn.stdpath("config") .. "/lua/custom/snippets",
  },
  fs_event_provders = {
    { libuv = true },
  },
})

-- load vscode snippet files
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({
  paths = {
    vim.fn.stdpath("config") .. "/lua/custom/vsc_snippets",
  },
})

vim.api.nvim_create_user_command("LuaSnipEdit", function()
  require("luasnip.loaders").edit_snippet_files()
end, {})

map("<M-j>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, "Expand or Jump")

map("<M-k>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, "Jump back")

map("<M-n>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, "Next choice")

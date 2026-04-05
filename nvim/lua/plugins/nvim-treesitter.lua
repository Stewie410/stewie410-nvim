vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "master" },
})

vim.api.nvim_create_autocmd({ "PackChanged" }, {
  group = vim.api.nvim_create_augroup("VimPackTSChanged", { clear = true }),
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
  desc = "Update TS Parsers"
})

if not vim.g.vim_pack_init.nvim_treesitter == 1 then
  require("nvim-treesitter.query_predicates")
  vim.g.pack_init.nvim_treesitter = 1
end

---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
  ensure_installed = "all",
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  ignore_install = { "ipkg" },
})

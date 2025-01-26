vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("q-always-quits", { clear = true }),
  pattern = {
    "help",
    "startuptime",
    "qf",
    "lspinfo",
    "man",
    "checkhealth",
    "neotest-output-panel",
    "neotest-summary",
    "lazy",
  },
  callback = function()
    vim.keymap.set(
      "n",
      "q",
      ":close<CR>",
      { silent = true, buffer = true, desc = "[Q]uit Window" }
    )
    vim.keymap.set(
      "n",
      "<Esc>",
      ":close<CR>",
      { silent = true, buffer = true, desc = "[Esc]ape Window" }
    )
  end,
  desc = "Quit special buffer types with q/<Esc>",
})

vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
  desc = "Quit special buffers with 'q' or <Esc>",
  group = vim.api.nvim_create_augroup("quitting", { clear = true }),
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
    "mason",
  },
  callback = function()
    local rhs = ":close<CR>"
    local opts = { silent = true, buffer = true, desc = "Quit" }

    vim.keymap.set("n", "q", rhs, opts)
    vim.keymap.set("n", "<Esc>", rhs, opts)
  end,
})

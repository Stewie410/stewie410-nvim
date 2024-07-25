return {
  dir = "~/git/Stewie410/nvim-lipsum",
  enabled = function()
    return vim.uv.fs_stat(vim.fn.expand("~/git/Stewie410/nvim-lipsum")) ~= nil
  end,
  cmd = {
    "LipsumWord",
    "LipsumLine",
    "LipsumParagraph",
  },
  opts = {},
}

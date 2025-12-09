local cmd = "vim-language-server"
if not vim.fn.executable(cmd) then
  return {}
end

---@type vim.lsp.Config
return {
  cmd = { cmd, "--stdio" },
  filetypes = { "vim" },
  root_markers = {
    ".vimrc",
    ".vim",
    ".git",
    ".svn",
  },
  init_options = {
    isNeovim = true,
    iskeyword = "@,48-57,_,192-255,-#",
    vimruntime = "",
    runtimepath = "",
    diagnostic = { enable = true },
    indexes = {
      runtimepath = true,
      gap = 100,
      count = 3,
      projectRootPatterns = {
        "runtime",
        "nvim",
        "autoload",
        "plugin",
        ".git",
        ".svn",
      },
    },
    suggest = { fromVimruntime = true, fromRuntimepath = true },
  },
}

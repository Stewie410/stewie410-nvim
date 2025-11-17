local jar = vim.fn.expand("~/.local/share/lsp/groovy-ls/groovy-language-server-all.jar")
return {
  cmd = { "java", "-jar", jar },
  filetypes = { "groovy" },
  root_markers = {
    ".jenkinsfile",
    ".git",
    ".svn",
  },
}

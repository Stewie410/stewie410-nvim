return {
  cmd = { "java", "-jar", "groovy-language-server-all.jar" },
  filetypes = { "groovy" },
  root_markers = {
    ".jenkinsfile",
    ".git",
    ".svn",
  },
}

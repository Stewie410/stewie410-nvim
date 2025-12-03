-- WARN: Will lag *hard* for ~/*.sh
return {
  cmd = { "bash-language-server", "start" },
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)",
      shfmt = {
        binaryNextLine = true,
        caseIndent = true,
        funcNextLine = false,
      },
    },
  },
  filetypes = { "bash", "sh" },
  root_markers = { ".git", ".svn" },
}

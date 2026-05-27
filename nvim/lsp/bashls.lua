-- https://github.com/k8s-1/bashls
local cmd = "bashls"
if not vim.fn.executable(cmd) then
  return {}
end

---@type vim.lsp.Config
return {
  cmd = { cmd, "start" },
  settings = {
    bashIde = {
      shellcheckArguments = {
        -- "--check-sourced",
        -- "--color=never",
        "--norc",
      },
      shfmt = {
        binaryNextLine = true,
        caseIndent = true,
        funcNextLine = false,
        spaceRedirects = true,
      },
    },
  },
  filetypes = {
    "bash",
    "sh",
    "zsh",
  },
  root_markers = {
    ".git",
    ".svn",
  },
}

local jar = vim.fn.expand("~/.local/share/lsp/groovy-ls/groovy-language-server-all.jar")
local cmd = "java"
if not vim.fn.executable(cmd) or not vim.uv.fs_stat(jar) then
  return {}
end

---@type vim.lsp.Config
return {
  cmd = { cmd, "-jar", jar },
  filetypes = { "groovy" },
  root_markers = {
    ".jenkinsfile",
    ".git",
    ".svn",
  },
  settings = {
    groovy = {
      classpath = {
        vim.fn.expand("~/.sdkman/candidates/groovy/current/lib"),
        vim.fn.expand("~/.groovy/lib"),
        vim.fn.expand("~/.groovy/grapes") .. "/**",
      },
    },
  },
}

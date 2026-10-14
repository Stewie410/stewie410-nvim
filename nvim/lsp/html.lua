local cmd = "vscode-html-language-server"
if not vim.fn.executable(cmd) then
  return {}
end

---@type vim.lsp.Config
return {
  cmd = { cmd, "--stdio" },
  filetypes = {
    "html",
    "templ",
    "tmpl",
  },
  root_markers = {
    "package.json",
  },
  settings = {},
  init_options = {
    provideFormatter = true,
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    configurationSection = {
      "html",
      "css",
      "javascript",
    },
  },
}

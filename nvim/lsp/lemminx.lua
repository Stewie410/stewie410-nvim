local cmd = "lemminx"
if not vim.fn.executable(cmd) then
  return {}
end

---@type vim.lsp.Config
return {
  cmd = { cmd },
  filetypes = {
    "xml",
    "xsd",
    "xsl",
    "xslt",
    "svg",
  },
  root_markers = {
    ".git",
    ".svn",
  },
}

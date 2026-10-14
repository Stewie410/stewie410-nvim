-- https://github.com/k8s-1/bashls
local cmd = "bashls"
if not vim.fn.executable(cmd) then
  return {}
end

---@type vim.lsp.Config
return {
  cmd = { cmd, "start" },
  filetypes = {
    "bash",
    "sh",
    "zsh",
  },
}

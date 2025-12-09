local cmd = "markdown-oxide"
if not vim.fn.executable(cmd) then
  return {}
end

---@type vim.lsp.Config
return {
  cmd = { "markdown-oxide" },
  filetypes = { "markdown" },
  capabilities = require("util.lsp.capabilities").with_blink({
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  }),
  root_markers = {
    ".obsidian",
    ".moxide.toml",
    ".git",
    ".svn",
  },
  on_attach = function(client, bufnr)
    local buf_cmd = vim.api.nvim_buf_create_user_command

    buf_cmd(bufnr, "Today", function()
      ---@diagnostic disable-next-line: missing-fields
      client:exec_cmd({ command = "jump", arguments = { "today" } })
    end, { desc = "Open today's daily note" })

    buf_cmd(bufnr, "Tomorrow", function()
      ---@diagnostic disable-next-line: missing-fields
      client:exec_cmd({ command = "jump", arguments = { "today" } })
    end, { desc = "Open tomorrow's daily note" })

    buf_cmd(bufnr, "Yesterday", function()
      ---@diagnostic disable-next-line: missing-fields
      client:exec_cmd({ command = "jump", arguments = { "yesterday" } })
    end, { desc = "Open yesterday's daily note" })
  end,
}

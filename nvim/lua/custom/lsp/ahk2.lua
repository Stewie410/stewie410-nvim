local M = {}

local function get_server()
  local child = "/vscode-autohotkey2-lsp/tools/server/dist/server.js"
  local possible = {
    vim.fn.expand("~/git"),
    "D:/dev/git",
  }

  for _, root in ipairs(possible) do
    if vim.uv.fs_stat(root .. child) then
      return root .. child
    end
  end

  vim.notify("Cannot locate AHKv2 LSP", vim.log.levels.WARN)
  return nil
end

local capabilities = require("custom.lsp.capabilities")
local exe = vim.fn.expand("$PROGRAMFILES/AutoHotKey/v2/AutoHotkey.exe")
local js = get_server()

local options = {
  autostart = true,
  cmd = { "node", js, "--stdio" },
  filetypes = { "ahk", "autohotkey", "ah2" },
  init_options = {
    locale = "en-us",
    InterpreterPath = exe,
    AutoLibInclude = "User and Standard",
    CommentTags = "^;;\\s*(?<tag>.+)",
    CompleteFunctionParens = false,
    Diagnostics = {
      ClassStaticMemberCheck = true,
      ParamsCheck = true,
    },
    ActionWhenV1IsDetected = "Continue",
    FormatOptions = {
      array_style = "none",
      break_chained_methods = false,
      ignore_comment = false,
      indent_string = "\t",
      max_preserve_newlines = 2,
      brace_style = "One True Brace",
      object_style = "none",
      preserve_newlines = true,
      space_after_double_colon = true,
      space_before_conditional = true,
      space_in_empty_paren = false,
      space_in_other = true,
      space_in_paren = false,
      wrap_line_length = 0,
    },
    WorkingDirs = {},
    SymbolFoldingFromOpenBrace = false,
  },
  single_file_support = true,
  flags = { debounce_text_changes = 500 },
  capabilities = capabilities,
  on_attach = M.custom_attach,
}

function M.server_installed()
  return js ~= nil
end

---@diagnostic disable-next-line: unused-local
function M.on_attach(client, bufnr)
  require("lsp_signature").on_attach({
    bind = true,
    use_lspsaga = false,
    floating_window = true,
    fix_pix = true,
    hint_enable = true,
    hi_parameter = "Search",
    handler_opts = { "double" },
  })
end

---setup AHKv2
---@param opts? table
function M.setup(opts)
  local config = vim.tbl_extend("keep", opts, options)
  local cfg = require("lspconfig.configs")
  cfg["ahk2"] = { default_config = config }
  require("lspconfig").ahk2.setup({})
end

return M

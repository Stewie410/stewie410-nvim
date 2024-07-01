local M = {}

-- determine server.js location
local server_js = "D:\\dev\\git"
if not vim.uv.fs_stat(server_js) then
  server_js = "~/git"
end
server_js = vim.fn.expand(
  server_js .. "/vscode-autohotkey2-lsp/tools/server/dist/server.js"
)

local function get_server_js()
  local root = "D:/dev/git"
  if not vim.uv.fs_stat(root) then
    root = vim.fn.expand("~/git")
  end

  local child = "/vscode-authotkey2-lsp/tools/server/dist/server.js"
  if not vim.uv.fs_stat(root .. child) then
    local msg = "Cannot locate AHK2 LSP Server: " .. root .. child
    vim.notify(msg, vim.log.levels.ERROR)
    error(msg, 2)
    -- return nil
  end

  return root .. child
end

local capabilities = require("custom.lsp.capabilities")
local exe = vim.fn.expand("$PROGRAMFILES/AutoHotKey/v2/AutoHotkey.exe")
local js = get_server_js()

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

function M.setup(opts)
  local config = vim.tbl_extend("keep", opts, options)
  local cfg = require("lspconfig.configs")
  cfg["ahk2"] = { default_config = config }
  require("lspconfig").ahk2.setup({})
end

return M

local M = {}

local capabilities = require("custom.lsp.capabilities")
local ahk2_exe = "/mnt/c/Program Files/AutoHotkey/v2/AutoHotkey.exe"

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

function M.setup()
    local cfg = require("lspconfig.configs")
    cfg["ahk2"] = { default_config = M.config }
    require("lspconfig").ahk2.setup({})
end

M.config = {
    autostart = true,
    cmd = {
        "node",
        vim.fn.expand(
            "~/git/vscode-autohotkey2-lsp/tools/server/dist/server.js"
        ),
        "--stdio",
    },
    filetypes = {
        "ahk",
        "autohotkey",
        "ah2",
    },
    init_options = {
        locale = "en-us",
        InterpreterPath = ahk2_exe,
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

return M

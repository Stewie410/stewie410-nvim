return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VimEnter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            ---@diagnostic disable-next-line: missing-fields
            configs.setup({
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })

            local parser_config =
                require("nvim-treesitter.parsers").get_parser_configs()

            parser_config["powershell"] = {
                install_info = {
                    url = vim.fn.expand("~/git/tree-sitter-PowerShell"),
                    files = { "src/parser.c" },
                    branch = "operator001",
                    generate_requires_npm = false,
                    requires_generate_from_grammer = false,
                },
                filetype = "PowerShell",
            }
        end,
    },
}

return {
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        priority = 100,
        dependencies = {
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-omni",
            {
                "L3MON4D3/LuaSnip",
                build = "make install_jsregexp",
                lazy = false,
            },
            "saadparwaiz1/cmp_luasnip",
            "kdheepak/cmp-latex-symbols",
        },
        config = function()
            require("custom.cmp")
            require("custom.cmp.luasnip")
        end,
    },
}
--

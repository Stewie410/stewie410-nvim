return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            {
                "<C-b>",
                function()
                    require("nvim-tree.actions.tree.toggle").fn({
                        file_file = true,
                    })
                end,
                desc = "Toggle file [B]rowser",
            },
        },
        opts = {
            filters = { dotfiles = true },
        },
    },
}

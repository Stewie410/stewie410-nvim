return {
    {
        "Willem-J-an/nvim-dap-powershell",
        event = "LspAttach",
        ft = "PowerShell",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            {
                "m00qek/baleia.nvim",
                tag = "v1.4.0",
            },
        },
        config = function()
            local dap = require("dap")
            local ui = require("dapui")
            local dps = require("dap-powershell")

            dps.setup()
            ui.setup()

            dap.listeners.after.event_initialized.dapui_config = function()
                ui.open({})
                dps.correct_repl_colors()
            end
        end,
    },
}

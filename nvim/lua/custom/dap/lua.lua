local M = {}

M.repo = vim.fn.expand("~/git/local-lua-debugger-vscode")

function M.get_config()
    return {
        name = "lua-lua",
        ft = "lua",
        adapter = {
            type = "executable",
            command = "node",
            args = { M.repo .. "/extension/debugAdapter.js" },
            enrich_config = function(config, on_config)
                if not config["extensionPath"] then
                    local c = vim.deepcopy(config)
                    c["extensionPath"] = M.repo .. "/"
                    on_config(c)
                else
                    on_config(config)
                end
            end,
        },
        config = {},
    }
end

return M

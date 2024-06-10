local M = {}

local proot = vim.fn.stdpath("data") .. "/mason/packages"

M.mason_package = proot .. "/bash-debug-adapter"
M.bashdb_dir = M.mason_package .. "/extension/bashdb_dir"

function M.get_config()
    return {
        name = "bashdb",
        ft = "sh",
        adapter = {
            type = "executable",
            command = M.mason_package,
            name = "bashdb",
        },
        config = {
            type = "bashdb",
            request = "launch",
            name = "Launch file",
            showDebugOutput = true,
            pathBashdb = M.bashdb_dir .. "/bashdb",
            pathBashdbLib = M.bashdb_dir,
            trace = true,
            file = "${file}",
            program = "${file}",
            cwd = "${workspaceFolder}",
            pathCat = "cat",
            pathBash = "/usr/bin/bash",
            pathMkfifo = "mkfifo",
            pathPkill = "pkill",
            args = {},
            env = {},
            terminalKind = "integrated",
        },
    }
end

return M

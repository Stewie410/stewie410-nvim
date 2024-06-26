local dap = require("dap")
local ui = require("dapui")

ui.setup()
require("dap-go").setup()

require("nvim-dap-virtual-text").setup({
  -- Mitigate leaking tokens
  display_callback = function(variable)
    local name = string.lower(variable.name)
    local value = string.lower(variable.value)

    if
      name:match("secret")
      or name:match("api")
      or value:match("secret")
      or value:match("api")
    then
      return "*****"
    end

    if #variable.value > 15 then
      return " " .. string.sub(variable.value, 1, 15) .. "... "
    end

    return " " .. variable.value
  end,
})

local map = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { desc = desc })
end

map("<leader>b", dap.toggle_breakpoint, "Toggle [B]reakpoint")
map("<leader>rc", dap.run_to_cursor, "[R]un to [C]ursor")
map("<leader>?", function()
  ---@diagnostic disable-next-line: missing-fields
  require("dapui").eval(nil, { enter = true })
end)
map("<F1>", dap.continue, "DAP: Continue")
map("<F2>", dap.step_into, "DAP: Step Into")
map("<F3>", dap.step_over, "DAP: Step Over")
map("<F4>", dap.step_out, "DAP: Step Out")
map("<F5>", dap.step_back, "DAP: Step Back")
map("<F12>", dap.restart, "DAP: Restart")

dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  ui.close()
end

local servers = {
  ["bash-debug-adapter"] = require("custom.dap.bash").get_config(),
  ["local-lua"] = require("custom.dap.lua").get_config(),
}

require("mason").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "bash-debug-adapter",
  },
})

for _, adp in pairs(servers) do
  dap.adapters[adp.name] = adp.adapter
  dap.configurations[adp.ft] = adp.config
end

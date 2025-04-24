local util = require("util.boiler")
-- util._is_debug = true

vim.keymap.set("n", "<leader>bw", util.pick_ft, { desc = "Boiler: Pick (ft)" })
vim.keymap.set("n", "<leader>bb", util.pick_all, { desc = "Boiler: Pick (*)" })
vim.keymap.set("n", "<leader>bs", util.scan, { desc = "Boiler: Scan" })

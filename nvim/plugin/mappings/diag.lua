local map = vim.keymap.set

map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Diagnostic: Previous" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Diagnostic: Next" })
map("n", "<leader>df", vim.diagnostic.open_float, { desc = "Diagnostic: Open List" })
map("n", "<leader>qf", vim.diagnostic.setloclist, { desc = "Diagnostic: Quick Fix List" })

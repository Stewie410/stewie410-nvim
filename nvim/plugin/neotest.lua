vim.pack.add({
	"https://github.com/nvim-neotest/neotest",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/antoinemadec/FixCursorHold.nvim",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "lua" },
	callback = function()
		---@diagnostic disable-next-line: missing-parameter, missing-fields
		require("neotest").setup({})
	end,
})

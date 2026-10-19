if require("util.dev").exists("boiler.nvim") then
	vim.pack.add({ "https://ithub.com/Grub4K/glib.nvim" })
	vim.cmd.packadd("boiler.nvim")
else
	vim.pack.add({
		"https://github.com/Stewie410/boiler.nvim",
		"https://github.com/Grub4K/glib.nvim",
	})
end

local boiler = require("boiler")
boiler.setup({
	picker = "snacks",
	paths = {
		vim.fn.resolve(os.getenv('XDG_CONFIG_HOME') .. '/boilerplate'),
		vim.fn.resolve(os.getenv('XDG_CONFIG_HOME') .. '/private/boilerplate'),
	},
})

vim.keymap.set("n", "<leader>bb", function() boiler.pick(vim.bo.filetype) end, {
	desc = "Boiler: Select from FT",
})
vim.keymap.set("n", "<leader>ba", function() boiler.pick() end, {
	desc = "Boiler: Select from Any",
})

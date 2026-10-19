local packs = {
	"https://github.com/Grub4K/glib.nvim",
	"https://github.com/folke/snacks.nvim",
}

if require("util.dev").exists("boiler.nvim") then
	vim.pack.add(packs)
	vim.cmd.packadd("boiler.nvim")
else
	table.insert(packs, "https://github.com/Stewie410/boiler.nvim")
	vim.pack.add(packs)
end

local globs = {
	vim.env.XDG_CONFIG_HOME .. "/boilerplate/**/*",
	vim.env.XDG_CONFIG_HOME .. "/private/boilerplate/**/*",
}

vim.keymap.set("n", "<leader>bb", function()
	local items = require("boiler.util").find(globs, vim.bo.filetype)
	if #items == 0 then
		vim.notify("boiler.nvim: no templates available", vim.log.levels.WARN)
		return
	end
	require("boiler.picker.snacks").pick(items)
end, { desc = "boiler.nvim: pick by ft" })

vim.keymap.set("n", "<leader>ba", function()
	local items = require("boiler.util").find(globs, nil)
	if #items == 0 then
		vim.notify("boiler.nvim: no templates available", vim.log.levels.WARN)
		return
	end
	require("boiler.picker.snacks").pick(items)
end, { desc = "boiler.nvim: pick any template" })

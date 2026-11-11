-- better ux
vim.o.number = false
vim.o.relativenumber = false
vim.o.scrolloff = 0
vim.o.sidescrolloff = 0
vim.o.spell = false
vim.o.signcolumn = "no"

local ag = vim.api.nvim_create_augroup("term.bgcol", { clear = true })

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
	desc = "Corrects terminal bg color",
	group = ag,
	callback = function()
		local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
		if bg then
			io.write(("\027]11;#%07x\027"):format(bg))
		end
	end,
})

vim.api.nvim_create_autocmd({ "UILeave" }, {
	desc = "Reset terminal background color",
	group = ag,
	callback = function()
		io.write("\027]111\027")
	end,
})

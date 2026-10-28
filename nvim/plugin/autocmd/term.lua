-- TODO: move to ftdetect + ftplugin?
vim.api.nvim_create_autocmd({ "TermOpen" }, {
	desc = "Sane terminal defaults",
	group = vim.api.nvim_create_augroup("term.sane", { clear = true }),
	callback = function()
		vim.bo.number = false
		vim.bo.relativenumber = false
		vim.bo.scrolloff = 0
		vim.bo.sidescrolloff = 0
		vim.bo.spell = false
		vim.bo.signcolumn = "no"
		vim.bo.filetype = "terminal"
		vim.bo.cursorlink = false
	end,
})

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
	desc = "Corrects terminal background color according to colorscheme",
	group = vim.api.nvim_create_augroup("term.bgcol.set", { clear = true }),
	callback = function()
		local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
		if bg then
			io.write(("\027]11;#%07x\027"):format(bg))
		end

		vim.api.nvim_create_autocmd({ "UILeave" }, {
			desc = "Reset terminal background color",
			group = vim.api.nvim_create_augroup("term.bgcol.reset", { clear = true }),
			callback = function()
				io.write("\027]111\027\\")
			end,
		})
	end,
})

vim.api.nvim_create_autocmd("PackChanged", {
	pattern = "*",
	desc = "Update gopher dependencies",
	callback = function(ev)
		if ev.data.spec.name == "gopher.nvim" and vim.tbl_contains({ "install", "update" }, ev.data.kind) then
			vim.cmd.GoInstallDeps()
		end
	end,
})

vim.pack.add({
	"https://github.com/olexsmir/gopher.nvim",
})

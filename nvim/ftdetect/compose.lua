vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	desc = "Detect (docker-)?compose.yml files",
	pattern = {
		"*docker-compose.yaml",
		"docker-compose*.yaml",
		"*compose.yml",
		"compose*.yml",
	},
	callback = function()
		vim.bo.filetype = "yaml.docker-compose"
		vim.bo.syntax = "yaml"
	end,
})

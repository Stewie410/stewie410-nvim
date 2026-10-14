---@type vim.lsp.Config
return {
	settings = {
		groovy = {
			classpath = {
				vim.fn.expand("~/.sdkman/candidates/groovy/current/lib"),
				vim.fn.expand("~/.groovy/lib"),
				vim.fn.expand("~/.groovy/grapes") .. "/**",
			},
		},
	},
}

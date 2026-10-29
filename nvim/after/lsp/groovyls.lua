---@module "lsp.settings.groovyls"

---@type vim.lsp.Config
return {
	---@type lsp.settings.groovyls
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

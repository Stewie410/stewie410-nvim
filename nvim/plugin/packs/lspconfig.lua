vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

vim.lsp.config("*", {
	capabilities = require("util.lsp.capabilities").native(),
	root_markers = {
		".git",
		".svn",
	},
})

vim.lsp.enable({
	"awk_ls",
	-- "bashls",
	"shuck",
	-- "shell-lsp",
	"jqls",
	"texlab",
	"lemminx",
	"pyright",
	"html",
	"diagnosticls",
	"jsonls",
	"yamlls",
	"taplo",
	"vimls",
	"lua_ls",
	-- "emmylua_ls",
	"markdown_oxide",
	"docker_compose_language_server",
	"groovyls",
	"dockerls",
	"gopls",
	"golangci_lint_ls",
	"systemd_lsp",
	"ls_lsp",
})

assert(vim.fn.executable("tree-sitter") == 1, "nvim-treesitter: missing 'tree-sitter' cli in PATH")

vim.api.nvim_create_autocmd({ "PackChanged" }, {
	callback = function(ev)
		local name, kind = ev.data.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
	desc = "Auto-Update TS Parsers",
})

vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
})

-- ensure installed
require("nvim-treesitter").install({
	"awk",
	"bash",
	"bibtex",
	"c",
	"c_sharp",
	"cmake",
	"comment",
	"css",
	"diff",
	"dockerfile",
	"editorconfig",
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitcommit",
	"gitignore",
	"go",
	"gomod",
	"gosum",
	"gotmpl",
	"gowork",
	"groovy",
	"html",
	"html_tags",
	"ini",
	"java",
	"javadoc",
	"javascript",
	"jq",
	"jsdoc",
	"json",
	"latex",
	"lua",
	"luadoc",
	"luap",
	"luau",
	"make",
	"markdown",
	"markdown_inline",
	"mermaid",
	"passwd",
	"powershell",
	"printf",
	"promql",
	"properties",
	"psv",
	"python",
	"query",
	"readline",
	"regex",
	"requirements",
	"robots_txt",
	"sql",
	"ssh_config",
	"templ",
	"todotxt",
	"toml",
	"udev",
	"vim",
	"vimdoc",
	"xcompose",
	"xml",
	"xresources",
	"yaml",
	"zsh",
})

-- enable highlighting
vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "enable treesitter",
	callback = function()
		local ok, _ = pcall(vim.treesitter.start)
		if not ok then
			return
		end
		-- folding
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"
		vim.o.foldenable = false
		vim.o.foldlevel = 20

		-- indents
		-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		-- vim.bo.autoindent = false
		-- vim.bo.smartindent = false
	end,
})

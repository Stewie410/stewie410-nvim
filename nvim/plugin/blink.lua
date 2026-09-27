vim.api.nvim_create_autocmd({ "PackChanged" }, {
	callback = function(ev)
		local name, kind = ev.data.name, ev.data.kind
		if name == "blink.cmp" and (kind == "install" or kind == "update") then
			vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path })
		end
	end,
	desc = "Build blink.cmp",
})

vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp",    version = "v1" },
	{ src = "https://github.com/saghen/blink.compat", version = "main" },
	-- "https://github.com/saghen/blink.lib",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/mikavilpas/blink-ripgrep.nvim",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

require("blink.cmp").setup({
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
		kind_icons = {
			Text = "",
			Method = "󰆧",
			Function = "󰊕",
			Constructor = "",

			Field = "󰇽",
			Variable = "󰂡",
			Property = "󰜢",

			Class = "󰠱",
			Interface = "",
			Struct = "",
			Module = "",

			Unit = "",
			Value = "󰎠",
			Enum = "",
			EnumMember = "",

			Keyword = "󰌋",
			Constant = "󰏿",

			Snippet = "",
			Color = "󰏘",
			File = "󰈙",
			Reference = "",
			Folder = "󰉋",
			Event = "",
			Operator = "󰆕",
			TypeParameter = "󰅲",
		},
	},
	completion = {
		menu = {
			border = "single",
		},
		trigger = {
			show_on_trigger_character = true,
		},
	},
	keymap = {
		preset = "default",
		["<C-y>"] = {},
		["<Tab>"] = {
			function(cmp)
				if cmp.snippet_active() then
					return cmp.accept()
				else
					return cmp.select_and_accept()
				end
			end,
			"snippet_forward",
			"fallback",
		},
	},
	sources = {
		default = {
			"lazydev",
			"lsp",
			"path",
			"snippets",
			"omni",
			"buffer",
			"ripgrep",
			"cmdline",
		},
		providers = {
			snippets = {
				score_offset = 50,
				opts = {
					search_paths = {
						vim.fn.resolve(os.getenv('XDG_CONFIG_HOME') .. '/snippets'),
						vim.fn.resolve(os.getenv('XDG_CONFIG_HOME') .. '/private/snippets'),
						vim.fn.stdpath("data") .. "/lazy/friendly-snippets",
						vim.fn.stdpath("config") .. "/snippets",
					},
				},
			},
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
			ripgrep = {
				name = "Ripgrep",
				module = "blink-ripgrep",
				opts = {
					project_root_marker = { ".git", ".svn" },
					backend = {
						ripgrep = {
							search_casing = "--smart-case",
						},
					},
				},
			},
			buffer = {
				score_offset = 0,
			},
		},
	},
	fuzzy = {
		-- TODO: fix fuzzy_rust?
		implementation = "lua",
	},
	cmdline = {
		keymap = {
			preset = "cmdline",
			["<Tab>"] = { "show", "accept" },
		},
		completion = {
			menu = {
				---@diagnostic disable-next-line: unused-local
				auto_show = function(ctx)
					return vim.fn.getcmdtype() == ":"
				end,
			},
		},
	},
})

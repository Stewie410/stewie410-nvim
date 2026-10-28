vim.api.nvim_create_autocmd({ "PackChanged" }, {
	callback = function(ev)
		local name, kind = ev.data.name, ev.data.kind
		if name == "blink.cmp" and (kind == "install" or kind == "update") then
			---@diagnostic disable-next-line: undefined-field
			require("blink.cmp").build():pwait()
		end
	end,
	desc = "Build blink.cmp",
})

vim.pack.add({
	"https://github.com/saghen/blink.lib",
	{ src = "https://github.com/saghen/blink.compat", version = "main" },
	{ src = "https://github.com/saghen/blink.cmp",    version = "main" },
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/mikavilpas/blink-ripgrep.nvim",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/folke/lazydev.nvim",
})

---@module "blink.cmp"
---@type blink.cmp.Config
local opts = {
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
			"lsp",
			"path",
			"snippets",
			"omni",
			"buffer",
			"ripgrep",
			"cmdline",
		},
		per_filetype = {
			lua = {
				inherit_defaults = true,
				"lazydev",
			},
		},
		providers = {
			snippets = {
				score_offset = 50,
				opts = {
					search_paths = {
						vim.fn.resolve(os.getenv('XDG_CONFIG_HOME') .. '/snippets'),
						vim.fn.resolve(os.getenv('XDG_CONFIG_HOME') .. '/private/snippets'),
						vim.fn.stdpath("data") .. "/site/pack/core/opt/friendly-snippets",
						vim.fn.stdpath("config") .. "/snippets",
					},
				},
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
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
		},
	},
	fuzzy = {
		-- TODO: fix fuzzy_rust?
		implementation = "prefer_rust_with_warning",
	},
	cmdline = {
		keymap = {
			preset = "cmdline",
			["<Tab>"] = { "show", "accept" },
		},
		completion = {
			menu = {
				auto_show = function(_)
					return vim.fn.getcmdtype() == ":"
				end,
			},
		},
	},
}

---@diagnostic disable-next-line: undefined-field
require("blink.cmp").build():pwait()
require("blink.cmp").setup(opts)

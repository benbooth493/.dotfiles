local config = {
	updater = {
		remote = "origin",
		channel = "stable",
		version = "latest",
		branch = "main",
		commit = nil,
		pin_plugins = nil,
		skip_prompts = false,
		show_changelog = true,
		auto_reload = true,
		auto_quit = false,
	},

	plugins = {
		{ "catppuccin/nvim",        name = "catppuccin" },
		{ 'glepnir/nerdicons.nvim', cmd = 'NerdIcons',  config = function() require('nerdicons').setup({}) end },

		{
			"echasnovski/mini.nvim",
			event = "VimEnter",
			config = function()
				require('mini.ai').setup()
				require('mini.move').setup()
				require('mini.indentscope').setup()
				require('mini.splitjoin').setup()
				require('mini.trailspace').setup()
			end,
		},

		{
			"ggandor/leap.nvim",
			event = "VimEnter",
			config = function()
				require("leap").set_default_keymaps()
			end,
		},

		{
			"towolf/vim-helm",
			ft = "helm"
		},

		{
			"akinsho/flutter-tools.nvim",
			requires = 'nvim-lua/plenary.nvim',
			ft = "dart",
			config = function()
				require("flutter-tools").setup {}
			end,
		},

		{
			"anuvyklack/windows.nvim",
			event = "VimEnter",
			dependencies = {
				"anuvyklack/middleclass",
				"anuvyklack/animation.nvim",
			},
			config = function()
				vim.o.winwidth = 10
				vim.o.winminwidth = 10
				vim.o.equalalways = false
				require("windows").setup()
			end,
		},

		{
			"Wansmer/treesj",
			dependencies = { "nvim-treesitter" },
			config = function()
				require("treesj").setup()
			end,
		},

		{
			"mbbill/undotree",
			event = "VimEnter"
		},

		{
			"rcarriga/nvim-notify",
			opts = {
				stages = "fade",
				render = "minimal",
				top_down = false,
			}
		},

		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"lua",
					"go",
					"yaml",
					"json",
					"hcl",
					"bash",
					"rust",
					"terraform",
					"nix",
					"python",
					"elixir",
				},
			},
		},

		{
			"williamboman/mason-lspconfig.nvim",
			opts = {
				ensure_installed = {
					"gopls",
					"yamlls",
					"jsonls",
					"tsserver",
					"terraformls",
				}
			},
		},

		{
			"jay-babu/mason-null-ls.nvim",
			opts = function(_, config)
				local null_ls = require("null-ls")
				config.sources = {
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.golines,
					null_ls.builtins.formatting.terraform_fmt,

					null_ls.builtins.diagnostics.gitlint,
					null_ls.builtins.diagnostics.golangci_lint,
					null_ls.builtins.diagnostics.jsonlint,
					null_ls.builtins.diagnostics.markdownlint,
					null_ls.builtins.diagnostics.shellcheck,
				}
				return config
			end,
		},

		{
			"jay-babu/mason-nvim-dap.nvim",
			opts = {},
		},

		{
			"goolord/alpha-nvim",
			enabled = false,
			opts = function(_, opts)
				opts.section.header.val = {
					"",
					"",
					" ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓",
					" ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒",
					"▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░",
					"▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ",
					"▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒",
					"░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░",
					"░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░",
					"   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   ",
					"         ░    ░  ░    ░ ░        ░   ░         ░   ",
					"                                ░                  ",
					"",
					"",
				}
				return opts
			end,
		},

		{ 'Bekaboo/deadcolumn.nvim' },

		{
			"benfowler/telescope-luasnip.nvim",
			module = "telescope._extensions.luasnip",
		},
	},

	colorscheme = "catppuccin-mocha",

	options = {
		opt = {
			relativenumber = true,
			number = true,
			timeoutlen = 100,
			cursorcolumn = true,
			spell = false,
			signcolumn = "auto",
			wrap = false,
			swapfile = false,
			colorcolumn = '80,130',
		},

		g = {
			mapleader = " ",
			autoformat_enabled = true,
			cmp_enabled = true,
			autopairs_enabled = true,
			diagnostics_enabled = true,
			status_diagnostics_enabled = true,
			icons_enabled = true,
			ui_notifications_enabled = true,
		},
	},

	ui = {
		nui_input = true,
		telescope_select = true,
	},

	highlights = {},

	diagnostics = {
		virtual_text = true,
		virtual_lines = false,
		underline = true,
	},

	lsp = {
		servers = { "gopls", "terraformls" },
		formatting = {
			format_on_save = {
				enabled = true,
			},
		},
		config = {
			yamlls = {
				settings = {
					yaml = {
						schemas = {
							["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
							["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
							["http://json.schemastore.org/gitlab-ci"] = {
								".gitlab-ci.{yml,yaml}",
								".gitlab-ci/*.{yml, yaml}",
							},
						},
					},
				},
			},
		},
	},

	polish = function()
		vim.filetype.add({ extension = { tf = "terraform" } })

		require('telescope').load_extension('luasnip')
	end,
}

return config

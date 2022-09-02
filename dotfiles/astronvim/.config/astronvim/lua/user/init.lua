local config = {
	updater = {
		remote = "origin",
		channel = "nightly", -- "stable" or "nightly"
		version = "latest",
		branch = "main",
		commit = nil,
		pin_plugins = nil,
		skip_prompts = false,
		show_changelog = true,
	},

	options = {
		opt = {
			relativenumber = true,
			timeoutlen = 100,
		},
		g = {
			mapleader = " ",
			tokyonight_style = "night",
			tokyonight_italic_functions = true,
		},
	},

	ui = {
		nui_input = true,
		telescope_select = true,
	},

	colorscheme = "tokyonight",

	plugins = {
		init = {
			{ "folke/tokyonight.nvim" },

			{ "knubie/vim-kitty-navigator" },

			{
				"ggandor/leap.nvim",
				config = function()
					require("leap").set_default_keymaps()
				end,
			},

			{ "nvim-telescope/telescope-symbols.nvim" },

			{
				"stonelasley/flare.nvim",
				config = function()
					require("flare").setup()
				end,
			},

			{ "towolf/vim-helm" },

			{
				"abecodes/tabout.nvim",
				opt = true,
				want = { "nvim-treesitter" },
				after = { "nvim-cmp" },
				config = function()
					require("tabout").setup({
						completion = false,
						ignore_beginning = false,
					})
				end,
			},

			{
				"AckslD/nvim-trevJ.lua",
				config = function()
					require("trevj").setup()
				end,
				module = "trevj",
				setup = function()
					vim.keymap.set("n", ",j", function()
						require("trevj").format_at_cursor()
					end)
				end,
				disable = false,
			},

			{
				"dbinagi/nomodoro",
				config = function()
					require("nomodoro").setup({})
				end,
			},
		},

		["null-ls"] = function(config)
			local null_ls = require("null-ls")

			config.sources = {
				null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.gofumpt,
				null_ls.builtins.formatting.goimports,
				null_ls.builtins.formatting.golines,
				null_ls.builtins.formatting.terraform_fmt,
				null_ls.builtins.formatting.eslint_d,
				null_ls.builtins.formatting.dart_format,

				null_ls.builtins.diagnostics.flake8,
				null_ls.builtins.diagnostics.gitlint,
				null_ls.builtins.diagnostics.golangci_lint,
				null_ls.builtins.diagnostics.hadolint,
				null_ls.builtins.diagnostics.jsonlint,
				null_ls.builtins.diagnostics.luacheck,
				null_ls.builtins.diagnostics.markdownlint,
				null_ls.builtins.diagnostics.shellcheck,
				null_ls.builtins.diagnostics.staticcheck,
				null_ls.builtins.diagnostics.tsc,
				null_ls.builtins.diagnostics.yamllint,
			}

			config.on_attach = function(client)
				if client.resolved_capabilities.document_formatting then
					vim.api.nvim_create_autocmd("BufWritePre", {
						desc = "Auto format before save",
						pattern = "<buffer>",
						callback = vim.lsp.buf.formatting_sync,
					})
				end
			end
			return config
		end,

		treesitter = {
			ensure_installed = {
				"lua",
				"go",
				"python",
				"typescript",
				"yaml",
				"json",
				"hcl",
				"bash",
			},
		},

		["nvim-lsp-installer"] = {
			ensure_installed = {
				"sumneko_lua",
				"gopls",
				"yamlls",
				"jsonls",
				"tsserver",
				"terraformls",
			},
		},

		packer = {
			compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
		},

		bufferline = {
			options = {
				indicator = {
					icon = " ",
				},
			},
		},

		feline = function(config)
			local status = require("core.status")
			local hl = status.hl
			local provider = status.provider
			local conditional = status.conditional
			local C = require("default_theme.colors")

			config.components = {
				active = {
					{ -- LEFT SECTION
						{ provider = { name = "file_info", opts = { type = "relative-short" } } },
						{ provider = provider.spacer(1) },
						{
							provider = "git_branch",
							hl = hl.fg("Conditional", { fg = C.purple_1, style = "bold" }),
							icon = " ",
						},
						{ provider = provider.spacer(1), enabled = conditional.git_available },
						{ provider = "git_diff_added", hl = hl.fg("GitSignsAdd", { fg = C.green }), icon = "  " },
						{
							provider = "git_diff_changed",
							hl = hl.fg("GitSignsChange", { fg = C.orange_1 }),
							icon = " 柳",
						},
						{
							provider = "git_diff_removed",
							hl = hl.fg("GitSignsDelete", { fg = C.red_1 }),
							icon = "  ",
						},
						{ provider = provider.spacer(1), enabled = conditional.git_changed },
						{
							provider = "diagnostic_errors",
							hl = hl.fg("DiagnosticError", { fg = C.red_1 }),
							icon = "  ",
						},
						{
							provider = "diagnostic_warnings",
							hl = hl.fg("DiagnosticWarn", { fg = C.orange_1 }),
							icon = "  ",
						},
						{
							provider = "diagnostic_info",
							hl = hl.fg("DiagnosticInfo", { fg = C.white_2 }),
							icon = "  ",
						},
						{
							provider = "diagnostic_hints",
							hl = hl.fg("DiagnosticHint", { fg = C.yellow_1 }),
							icon = "  ",
						},
					},
					{ -- RIGHT SECTION
						{
							provider = function()
								return tostring(require("nomodoro").status())
							end,
						},
						{ provider = provider.lsp_progress, enabled = conditional.bar_width() },
						{ provider = "lsp_client_names", enabled = conditional.bar_width(), icon = "   " },
						{ provider = provider.spacer(1), enabled = conditional.bar_width() },
						{
							provider = provider.treesitter_status,
							enabled = conditional.bar_width(),
							hl = hl.fg("GitSignsAdd", { fg = C.green }),
						},
						{ provider = provider.spacer(1) },
						{ provider = "position" },
					},
				},
			}
			return config
		end,
	},

	luasnip = {
		vscode_snippet_paths = {},
		filetype_extend = {
			javascript = { "javascriptreact" },
		},
	},

	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			luasnip = 750,
			buffer = 500,
			path = 250,
		},
	},

	lsp = {
		on_attach = function(client)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end,

		["server-settings"] = {
			yamlls = {
				settings = {
					yaml = {
						schemas = {
							["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
							["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
						},
					},
				},
			},
		},
	},

	diagnostics = {
		virtual_text = true,
		virtual_lines = false,
		underline = true,
	},

	polish = function()
		local map = vim.api.nvim_set_keymap

		map("n", "<leader>D", ":Telescope lsp_type_definitions<cr>", { desc = "Find type definitions" })
		map("n", "<leader>faf", ":Telescope find_files hidden=true no_ignore=true<cr>", { desc = "Find hidden files" })

		vim.keymap.set("n", "<C-s>", ":w!<CR>")

		vim.api.nvim_create_augroup("packer_conf", { clear = true })

		vim.api.nvim_create_autocmd("BufWritePost", {
			desc = "Sync packer after modifying plugin.lua",
			group = "packer_conf",
			pattern = "plugins.lua",
			command = "source <afile> | PackerSync",
		})
	end,
}

return config

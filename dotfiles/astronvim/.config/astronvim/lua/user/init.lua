local config = {
	options = {
		opt = {
			relativenumber = true,
			timeoutlen = 100,
		},
		g = {
			mapleader = " ",
		},
	},

	ui = {
		nui_input = true,
		telescope_select = true,
	},

	plugins = {
		init = {
			{
				"sainnhe/sonokai",
				config = function()
					vim.g.sonokai_style = "andromeda"
					vim.g.sonokai_enable_italic = 0
					vim.g.sonokai_better_performance = 1
					vim.g.sonokai_diagnostic_text_highlight = 1
					vim.cmd("colorscheme sonokai")
				end,
			},

			{
				"ray-x/lsp_signature.nvim",
				event = "BufRead",
				config = function()
					require("lsp_signature").setup({
						bind = true,
						handler_opts = {
							border = "rounded",
						},
					})
				end,
			},

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
				"s1n7ax/nvim-window-picker",
				tag = "v1.*",
				config = function()
					require("window-picker").setup()
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

				null_ls.builtins.code_actions.shellcheck,

				null_ls.builtins.diagnostics.checkmake,
				null_ls.builtins.diagnostics.flake8,
				null_ls.builtins.diagnostics.gitlint,
				null_ls.builtins.diagnostics.golangci_lint,
				null_ls.builtins.diagnostics.hadolint,
				null_ls.builtins.diagnostics.jsonlint,
				null_ls.builtins.diagnostics.luacheck,
				null_ls.builtins.diagnostics.markdownlint,
				null_ls.builtins.diagnostics.mdl,
				null_ls.builtins.diagnostics.revive,
				null_ls.builtins.diagnostics.selene,
				null_ls.builtins.diagnostics.shellcheck,
				null_ls.builtins.diagnostics.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
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
			},
		},

		["nvim-lsp-installer"] = {
			ensure_installed = {
				"sumneko_lua",
				"gopls",
				"yamlls",
				"jsonls",
				"tsserver",
			},
		},

		packer = {
			compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
		},

		bufferline = {
			options = {
				indicator_icon = " ",
			},
		},
		lualine = {
			options = {
				theme = "sonokai",
			},
		},
	},

	luasnip = {
		vscode_snippet_paths = {},
		filetype_extend = {
			javascript = { "javascriptreact" },
		},
	},

	["which-key"] = {
		register_n_leader = {
			f = {
				e = { "<cmd>Telescope symbols<cr>", "Emojis" },
			},
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
		underline = true,
	},

	polish = function()
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

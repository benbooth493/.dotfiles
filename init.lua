local config = {
	-- Disable AstroVim ui features
	ui = {
		nui_input = true,
		telescope_select = true,
	},

	-- Configure plugins
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
	},

	-- Add paths for including more VS Code style snippets in luasnip
	luasnip = {
		vscode_snippet_paths = {},
		filetype_extend = {
			javascript = { "javascriptreact" },
		},
	},

	-- Modify which-key registration
	["which-key"] = {
		-- Add bindings to the normal mode <leader> mappings
		register_n_leader = {
			-- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
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

	-- Extend LSP configuration
	lsp = {
		-- add to the server on_attach function
		-- on_attach = function(client, bufnr)
		-- end,

		-- override the lsp installer server-registration function
		-- server_registration = function(server, opts)
		--   server:setup(opts)
		-- end
		on_attach = function(client)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end,

		-- Add overrides for LSP server settings, the keys are the name of the server
		["server-settings"] = {
			-- example for addings schemas to yamlls
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

	["null-ls"] = function(config)
		local null_ls = require "null-ls"

		config.sources = {
				null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.gofumpt,
				null_ls.builtins.formatting.goimports,
				null_ls.builtins.formatting.golines,
				null_ls.builtins.formatting.terraform_fmt,
				null_ls.builtins.formatting.eslint_d,
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

	diagnostics = {
		virtual_text = true,
		underline = true,
	},

	polish = function()
		vim.opt.relativenumber = true
		vim.opt.timeoutlen = 100

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

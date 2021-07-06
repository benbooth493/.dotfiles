local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
    return
end

packer.init {
    compile_path = require("packer.util").join_paths(vim.fn.stdpath "config", "plugin", "packer_compiled.vim"),
    git = { clone_timeout = 300 },
    display = {
        open_fn = function()
            return require("packer.util").float { border = "single" }
        end,
    },
}

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile"

return require('packer').startup(function(use)

    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim'}

    -- Color scheme
    use {'kyazdani42/nvim-web-devicons'}
    use {'dracula/vim', as = 'dracula'}

    -- Development
    use {'tpope/vim-dispatch'}
    use {'tpope/vim-fugitive'}
    use {'tpope/vim-surround'}
    use {'tpope/vim-commentary'}
    use {'tpope/vim-rhubarb'}
    use {'tpope/vim-unimpaired'}
    use {'tpope/vim-vinegar'}
    use {'wellle/targets.vim'}
    use {'easymotion/vim-easymotion'}
    use {'liuchengxu/vim-which-key'}

    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup() end
    }

    use {
        'TimUntersberger/neogit',
        config = function() require('neogit').setup() end
    }

    use {'kyazdani42/nvim-tree.lua'}

    use {
        'aserowy/tmux.nvim',
        config = function()
            require("tmux").setup({
                navigation = {
                    enable_default_keybindings = true,
                },
                resize = {
                    enable_default_keybindings = true,
                }
            })
        end
    }

    -- Telescope
    use {'nvim-lua/plenary.nvim'}
    use {'nvim-lua/popup.nvim'}
    use {'nvim-telescope/telescope.nvim'}

    use {
        'nvim-telescope/telescope-frecency.nvim',
        requires = {'tami5/sql.nvim'},
        config = function()
            require('telescope').load_extension('frecency')
        end
    }

    use {'nvim-telescope/telescope-symbols.nvim'}
    use {'nvim-telescope/telescope-github.nvim'}

    -- LSP config
    use {'neovim/nvim-lspconfig'}

    -- Completion
    use {
        'hrsh7th/nvim-compe',
    }

    use {
        'tzachar/compe-tabnine',
        run = './install.sh',
        requires = 'hrsh7th/nvim-compe',
    }

    -- Better LSP experience
    use {'glepnir/lspsaga.nvim'}
    use {'onsails/lspkind-nvim'}
    use {'sbdchd/neoformat'}
    use {'p00f/nvim-ts-rainbow'}
    use {'ray-x/lsp_signature.nvim'}
    use {'szw/vim-maximizer'}
    use {'dyng/ctrlsf.vim'}
    use {'dbeniamine/cheat.sh-vim'}
    use {'kevinhwang91/nvim-bqf'}
    use {'junegunn/vim-peekaboo'}
    use {'pechorin/any-jump.vim'}
    use {'windwp/nvim-autopairs'}

    -- Snippets
    use {'hrsh7th/vim-vsnip'}
    use {'rafamadriz/friendly-snippets'}
    use {'cstrap/python-snippets'}
    use {'ylcnfrht/vscode-python-snippet-pack'}
    use {'xabikos/vscode-javascript'}
    use {'golang/vscode-go'}
    use {'rust-lang/vscode-rust'}

    -- Better syntax
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    -- Status line
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        config = function() require 'statusline' end
    }

    -- Debugging
    use {'puremourning/vimspector'}
    use {'nvim-telescope/telescope-vimspector.nvim'}

    -- DAP
    use {'mfussenegger/nvim-dap'}
    use {'nvim-telescope/telescope-dap.nvim'}
    use {'mfussenegger/nvim-dap-python'}

    -- Telescope fzf
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

    -- Rust
    use {'rust-lang/rust.vim'}

    -- Go
    use {'fatih/vim-go', run = ':GoUpdateBinaries'}

    -- Misc
    use {'npxbr/glow.nvim', run = ':GlowInstall'}
    use {'romgrk/barbar.nvim'}
    use {'hashivim/vim-terraform'}
    use {'ggandor/lightspeed.nvim'}
    use {'jjo/vim-cue'}
    use {'towolf/vim-helm'}
    use {'itkq/fluentd-vim'}

    -- Orgmode
    use {'kristijanhusak/orgmode.nvim',
        config = function()
            require('orgmode').setup({
                org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
                org_default_notes_file = '~/Dropbox/org/refile.org',
            })
        end
    }
end)

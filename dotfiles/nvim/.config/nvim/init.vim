filetype indent plugin on
syntax enable

let mapleader = " "

" Possibly more ergonomic than mapping ESC to CAPSLOCK
inoremap jk <ESC>

let g:python3_host_prog='/usr/local/bin/python3'

call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'edkolev/tmuxline.vim'
Plug 'itchyny/lightline.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'hashivim/vim-terraform'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'rstacruz/vim-closer'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'aonemd/kuroi.vim'

call plug#end()

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_Co=256
set background=dark
"colorscheme palenight
colorscheme kuroi
hi LineNr ctermbg=NONE

set ai
set autoread
set backspace=eol,start,indent
set cmdheight=2
set clipboard=unnamed
set cot=menuone,noinsert,noselect
set encoding=utf8
set expandtab
set ffs=unix,dos,mac
set foldlevel=99
set hidden
set history=500
set hlsearch
set ignorecase
set incsearch
set lazyredraw
set list listchars=tab:▸\ ,trail:·,precedes:←,extends:→,eol:↲,nbsp:␣
set magic
set mat=2
set mouse=a
set nobackup
set noerrorbells
set noshowmode
set noswapfile
set novisualbell
set nowb
set nowrap
set nowritebackup
set number relativenumber
set shiftwidth=4
set shortmess+=c
set showbreak=↪\
set showmatch
set si
set signcolumn=yes
set smartcase
set smarttab
set so=10
set splitbelow
set splitbelow
set splitright
set t_vb=
set tabstop=4
set tm=500
set undodir=~/.undo//
set undofile
set updatetime=100
set whichwrap+=<,>,h,l
set wildmenu
set wrap

autocmd TermOpen * setlocal nonumber norelativenumber

" Autocorrent typos
iabbrev flase false
iabbrev vaule value

:lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}
EOF

:lua <<EOF
  local lspconfig = require('lspconfig')

  local on_attach = function(_, bufnr)
    require('completion').on_attach()
  end

  local servers = {
    'jsonls',
    'vimls',
    'pyls_ms',
    'gopls',
  }

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup{
      on_attach = on_attach,
    }
  end
EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:lightline = {
    \ 'colorscheme': 'palenight',
    \ }

let g:tmuxline_powerline_separators = 0

let g:completion_confirm_key = "\<C-y>"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

let g:terraform_align = 1
let g:terraform_fmt_on_save = 1

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" fzf
let g:fzf_layout = {
    \ 'up':'~90%',
    \ 'window': {
        \ 'width': 0.8,
        \ 'height': 0.8,
        \ 'yoffset': 0.5,
        \ 'xoffset': 0.5,
        \ 'highlight': 'Comment',
        \ 'border': 'sharp',
        \ }
    \ }

let g:fzf_tags_command = 'ctags -R'

nnoremap <Leader>p :Files<CR>
nnoremap <Leader>r :Rg<CR>

nnoremap <Leader>gi :GoImports<CR>
nnoremap <Leader>gie :GoIfErr<CR>
nnoremap <Leader>gl :GoMetaLinter<CR>

let g:go_highlight_functions = 1
let g:go_template_use_pkg = 0
let g:go_metalinter_autosave = 0
let g:go_imports_autosave = 1

au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

command! -nargs=* T split | terminal <args>
command! -nargs=* VT vsplit | terminal <args>

autocmd BufEnter * lua require'completion'.on_attach()


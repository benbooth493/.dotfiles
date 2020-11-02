filetype indent plugin on

let g:python3_host_prog='/usr/local/bin/python3'

call plug#begin('~/.config/nvim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'edkolev/tmuxline.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'itchyny/lightline.vim'
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
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'easymotion/vim-easymotion'
call plug#end()

set t_Co=256
colorscheme dracula
syntax enable
hi LineNr ctermbg=NONE

set ai
set autoread
set backspace=eol,start,indent
set cmdheight=2
set clipboard=unnamed
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
set signcolumn=number
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
set updatetime=300
set whichwrap+=<,>,h,l
set wildmenu
set wrap

source $HOME/.config/nvim/coc.vim

" Autocorrent typos
iabbrev flase false

let mapleader = ","

let g:lightline = {
    \ 'colorscheme': 'dracula',
    \ }

let g:tmuxline_powerline_separators = 0

let g:terraform_align=1
let g:terraform_fmt_on_save=1

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

function! s:sink(line)
  put=split(trim(a:line), '\s\+')[0]
endfunction

command! Acc call fzf#run({'source': 'dazn aws ls', 'sink': function('s:sink')})

nnoremap <Leader>da :Acc<CR>

command! -nargs=* T split | terminal <args>
command! -nargs=* VT vsplit | terminal <args>

nnoremap <Leader>fi gg=G<CR>


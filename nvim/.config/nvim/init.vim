filetype indent plugin on

let g:python3_host_prog='/usr/local/bin/python3'

call plug#begin('~/.config/nvim/plugged')
Plug 'edkolev/tmuxline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'hashivim/vim-terraform'
Plug 'jiangmiao/auto-pairs'
Plug 'phanviet/vim-monokai-pro'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'alok/notational-fzf-vim'
Plug 'voldikss/vim-floaterm'
Plug 'wincent/corpus'
call plug#end()

set t_Co=256
colorscheme monokai_pro
syntax enable
hi LineNr ctermbg=NONE

set ai
set autoread
set backspace=eol,start,indent
set clipboard=unnamed
set encoding=utf8
set expandtab
set ffs=unix,dos,mac
set foldlevel=99
set hid
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
set number relativenumber
set shiftwidth=4
set showbreak=↪\
set showmatch
set si
set smartcase
set smarttab
set so=10
set splitbelow
set splitbelow
set splitright
set t_vb=
set tabstop=4
set tm=500
set undodir=$HOME"/.undodir"
set undofile
set updatetime=300
set whichwrap+=<,>,h,l
set wildmenu
set wrap

let mapleader = " "

let g:lightline = {
    \ 'colorscheme': 'monokai_pro',
    \ }

let g:tmuxline_powerline_separators = 0

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

let g:go_highlight_functions = 1
let g:go_template_use_pkg = 0
let g:go_metalinter_autosave = 0
let g:go_imports_autosave = 1

let g:terraform_align=1
let g:terraform_fmt_on_save=1

let g:nv_search_paths = ['~/notes']

let g:floaterm_width = 0.95
let g:floaterm_height = 0.6
let g:floaterm_position = 'bottom'
let g:floaterm_autoclose = 1

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" fzf
nnoremap <Leader>p :Files<CR>
nnoremap <Leader>r :Rg<CR>

nnoremap <Leader>gi :GoImports<CR>
nnoremap <Leader>gie :GoIfErr<CR>
nnoremap <Leader>gl :GoMetaLinter<CR>

" notational fzf
nnoremap <Leader>n :NV<CR>

nnoremap <Leader>t :FloatermNew<CR>

au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

function! s:sink(line)
  put=split(trim(a:line), '\s\+')[0]
endfunction

command! Acc call fzf#run({'source': 'dazn aws ls', 'sink': function('s:sink')})

nnoremap <Leader>da :Acc<CR>


if &compatible
    set nocompatible
endif

filetype indent plugin on
syntax enable

let mapleader = " "

" Possibly more ergonomic than mapping ESC to CAPSLOCK
inoremap jk <ESC>

let g:python3_host_prog='/usr/local/bin/python3'

function! s:packager_init(packager) abort
    call a:packager.add('kristijanhusak/vim-packager', { 'type': 'opt' })

    call a:packager.add('neovim/nvim-lspconfig')
    call a:packager.add('nvim-lua/completion-nvim')

    call a:packager.add('rbong/vim-crystalline')
    call a:packager.add('aonemd/kuroi.vim')
    call a:packager.add('kyazdani42/nvim-web-devicons')

    call a:packager.add('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'})

    call a:packager.add('junegunn/fzf', { 'do': { -> fzf#install() } })
    call a:packager.add('junegunn/fzf.vim')

    call a:packager.add('nvim-lua/popup.nvim')
    call a:packager.add('nvim-lua/plenary.nvim')
    call a:packager.add('nvim-telescope/telescope.nvim')

    call a:packager.add('airblade/vim-gitgutter')
    call a:packager.add('tpope/vim-fugitive')

    call a:packager.add('fatih/vim-go', { 'do': ':GoUpdateBinaries' })
    call a:packager.add('hashivim/vim-terraform')
    call a:packager.add('dart-lang/dart-vim-plugin')
    call a:packager.add('thosakwe/vim-flutter')

    call a:packager.add('tpope/vim-surround')
    call a:packager.add('tpope/vim-repeat')
    call a:packager.add('rstacruz/vim-closer')
    call a:packager.add('AndrewRadev/splitjoin.vim')

    call a:packager.add('tweekmonster/startuptime.vim')
endfunction

packadd vim-packager
call packager#setup(function('s:packager_init'))

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_Co=256
set background=dark
colorscheme kuroi
hi LineNr ctermbg=NONE
let &colorcolumn="80,".join(range(120,999),",")

function! StatusLine(current, width)
  let l:s = ''

  if a:current
    let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
  else
    let l:s .= '%#CrystallineInactive#'
  endif
  let l:s .= ' %f%h%w%m%r '
  if a:current
    let l:s .= crystalline#right_sep('', 'Fill') . ' %{fugitive#head()}'
  endif

  let l:s .= '%='
  if a:current
    let l:s .= crystalline#left_sep('', 'Fill') . ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
    let l:s .= crystalline#left_mode_sep('')
  endif
  if a:width > 80
    let l:s .= ' ℓ %l/%L 𝑐 %c%V %P '
  else
    let l:s .= ' '
  endif

  return l:s
endfunction

let g:crystalline_enable_sep = 0
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_theme = 'default'

set guioptions-=e
set laststatus=2

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

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

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
    'dartls',
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

let g:completion_confirm_key = "\<C-y>"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

let g:terraform_align = 1
let g:terraform_fmt_on_save = 1

let g:dart_style_guide = 2
let g:dart_format_on_save = 1
let dart_html_in_strings=v:true

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


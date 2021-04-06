if &compatible
    set nocompatible
endif

filetype indent plugin on
syntax enable

let mapleader = " "

" Possibly more ergonomic than mapping ESC to CAPSLOCK
inoremap jk <ESC>

let g:python3_host_prog='/usr/local/bin/python3'

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'oberblastmeister/neuron.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'preservim/nerdcommenter'
Plug 'towolf/vim-helm'
Plug 'tweekmonster/startuptime.vim'
call plug#end()

set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_Co=256
set background=dark
colorscheme dracula
hi LineNr ctermbg=NONE
let &colorcolumn="80,".join(range(120,999),",")

let g:lightline = {
  \ 'colorscheme': 'dracula'
\}

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

autocmd TermOpen * setlocal nonumber norelativenumber

" Autocorrent typos
iabbrev flase false
iabbrev vaule value

let g:terraform_align = 1
let g:terraform_fmt_on_save = 1

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"" fzf
"let g:fzf_layout = {
    "\ 'up':'~90%',
    "\ 'window': {
        "\ 'width': 0.8,
        "\ 'height': 0.8,
        "\ 'yoffset': 0.5,
        "\ 'xoffset': 0.5,
        "\ 'highlight': 'Comment',
        "\ 'border': 'sharp',
        "\ }
    "\ }

"let g:fzf_tags_command = 'ctags -R'

"nnoremap <Leader>, :Files<CR>
"nnoremap <Leader>r :Rg<CR>

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

" Coc settings
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

lua << EOL
require'neuron'.setup {
    virtual_titles = true,
    mappings = true,
    run = nil, -- function to run when in neuron dir
    neuron_dir = "~/neuron", -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
    leader = "gz", -- the leader key to for all mappings, remember with 'go zettel'
}
EOL

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


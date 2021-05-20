local utils = require('utils')

local cmd = vim.cmd
local o = vim.o
local bo = vim.bo
local wo = vim.wo
local indent = 4

cmd 'syntax enable'
cmd 'filetype plugin indent on'
cmd 'colorscheme dracula'

bo.shiftwidth = indent
bo.tabstop = indent
bo.softtabstop = indent
bo.autoindent = true

o.backspace = 'eol,start,indent'
o.autoread = true
o.background = 'dark'
o.t_Co = '256'
o.termguicolors = true
o.hidden = true
o.ignorecase = true
o.scrolloff = 4
o.splitbelow = true
o.splitright = true
o.wildmode = 'list:longest'
o.clipboard = 'unnamed,unnamedplus'
o.timeoutlen = 500
o.updatetime = 300
o.mouse = 'a'
o.completeopt = 'menuone,noinsert,noselect'
o.cmdheight = 2
o.showmode = false

wo.number = true
wo.relativenumber = true
wo.scrolloff = 8
wo.cursorline = true
wo.signcolumn = 'yes'

cmd [[
set expandtab smarttab shiftround autoindent smartindent smartcase
]]

cmd [[
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
]]

cmd [[
let &colorcolumn="80,".join(range(120,999),",")
]]

cmd [[
set list listchars=tab:▸\ ,trail:·,precedes:←,extends:→,eol:↲,nbsp:␣
]]

cmd 'set so=10'

cmd [[
set undodir=~/.undo// undofile
]]

-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

-- Auto format
vim.api.nvim_exec([[
augroup auto_fmt
    autocmd!
    autocmd BufWritePre *.py,*.lua,*.go try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup END
]], false)

vim.api.nvim_exec([[
augroup auto_spellcheck
    autocmd!
    autocmd BufNewFile,BufRead *.md setlocal spell
    autocmd BufNewFile,BufRead *.org setfiletype markdown
    autocmd BufNewFile,BufRead *.org setlocal spell
    autocmd BufNewFile,BufRead *.html setlocal ts=2 sw=2 expandtab
    autocmd BufNewFile,BufRead *.js setlocal ts=2 sw=2 expandtab
    autocmd BufNewFile,BufRead *.json setlocal syntax=off expandtab
augroup END
]], false)

vim.api.nvim_exec([[
augroup auto_term
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen * startinsert
augroup END
]], false)

vim.api.nvim_exec([[
    fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun
    autocmd FileType go,rust,html,typescript,javascript,python autocmd BufWritePre <buffer> call TrimWhitespace()
]], false)

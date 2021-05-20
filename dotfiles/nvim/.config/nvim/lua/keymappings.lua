local utils = require('utils')

utils.map('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
utils.map('i', 'jk', '<Esc>')           -- jk to escape

utils.map('n', 's', ":HopChar2<CR>", {silent = true})
utils.map('n', 'S', ":HopWord<CR>", {silent = true})

utils.map('n', '<Leader>t', ":NvimTreeToggle<CR>", {silent = true})

vim.api.nvim_exec([[

" Nicer window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

]], false)

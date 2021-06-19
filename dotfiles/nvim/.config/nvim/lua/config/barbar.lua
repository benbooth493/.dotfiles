local utils = require('utils')

-- Move to previous/next
utils.map('n', '<A-,>', ':BufferPrevious<CR>', {noremap = true, silent = true})
utils.map('n', '<A-.>', ':BufferNext<CR>', {noremap = true, silent = true})
-- Reorder to previous/next
utils.map('n', '<A-<>', ':BufferMovePrevious<CR>', {noremap = true, silent = true})
utils.map('n', '<A->>', ':BufferMovePrevious<CR>', {noremap = true, silent = true})
-- Goto buffer in position
utils.map('n', '<A-1>', ':BufferGoto 1<CR>', {noremap = true, silent = true})
utils.map('n', '<A-2>', ':BufferGoto 2<CR>', {noremap = true, silent = true})
utils.map('n', '<A-3>', ':BufferGoto 3<CR>', {noremap = true, silent = true})
utils.map('n', '<A-4>', ':BufferGoto 4<CR>', {noremap = true, silent = true})
utils.map('n', '<A-5>', ':BufferGoto 5<CR>', {noremap = true, silent = true})
utils.map('n', '<A-6>', ':BufferGoto 6<CR>', {noremap = true, silent = true})
utils.map('n', '<A-7>', ':BufferGoto 7<CR>', {noremap = true, silent = true})
utils.map('n', '<A-8>', ':BufferGoto 8<CR>', {noremap = true, silent = true})
utils.map('n', '<A-9>', ':BufferLast<CR>', {noremap = true, silent = true})
-- Close buffer
utils.map('n', '<A-c>', ':BufferClose<CR>', {noremap = true, silent = true})
-- Magic buffer-picking mode
utils.map('n', '<C-s>', ':BufferPick<CR>', {noremap = true, silent = true})
-- Sort automatically by...
utils.map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', {noremap = true, silent = true})
utils.map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', {noremap = true, silent = true})

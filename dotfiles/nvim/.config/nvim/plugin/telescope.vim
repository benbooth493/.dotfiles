" Find files using Telescope command-line sugar.
nnoremap <silent> <leader>ff :Telescope git_files<CR>
nnoremap <silent> <leader>fg :Telescope live_grep<cr>
nnoremap <silent> <leader>fb :Telescope buffers<cr>
nnoremap <silent> <leader>ft :Telescope help_tags<cr>
nnoremap <silent> <leader>fe :Telescope file_browser<cr>
nnoremap <silent> <leader>fr :Telescope frecency<CR>
nnoremap <silent> <leader>fy :Telescope symbols<CR>

nnoremap <silent> <leader>fa :lua require('telescope').extensions.arecibo.websearch()<CR>
nnoremap <silent> <leader>fd :lua require('config.telescope').search_dotfiles()<CR>

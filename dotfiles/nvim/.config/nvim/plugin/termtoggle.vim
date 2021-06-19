let g:term_buf = 0
let g:term_win = 0

function! TermToggle()
    let l:term_height = 20
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . l:term_height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

nnoremap <silent> <leader><leader>t :call TermToggle()<cr>
tnoremap <silent> <leader><leader>t <C-\><C-n>:call TermToggle()<cr>

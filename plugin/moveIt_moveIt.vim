if !exists("g:moveIt_moveIt_no_mappings") || !g:moveIt_moveIt_no_mappings
    if !exists("g:moveIt_moveIt_alt_mappings") || !g:moveIt_moveIt_alt_mappings
        noremap  M m
        nnoremap mm :<c-u>set operatorfunc=MoveItOperator1<cr>0v$g@
        nnoremap m  :set operatorfunc=MoveItOperator1<cr>g@
        vnoremap m  :<c-u>call MoveItOperator1(visualmode())<cr>
        nnoremap mcc :<c-u>set operatorfunc=CopyItOperator1<cr>0v$g@
        nnoremap mc :set operatorfunc=CopyItOperator1<cr>g@
        vnoremap mc :<c-u>call CopyItOperator1(visualmode())<cr>
    else
        nnoremap Mm :<c-u>set operatorfunc=MoveItOperator1<cr>0v$g@
        nnoremap M  :set operatorfunc=MoveItOperator1<cr>g@
        vnoremap M  :<c-u>call MoveItOperator1(visualmode())<cr>
        nnoremap Mcc :<c-u>set operatorfunc=CopyItOperator1<cr>0v$g@
        nnoremap Mc :set operatorfunc=CopyItOperator1<cr>g@
        vnoremap Mc :<c-u>call CopyItOperator1(visualmode())<cr>
    endif
endif

function! MoveItOperator1(type)
    let s:reg_save = @@
    let s:cursor_line = line(".")
    if a:type ==# 'v'
        exe "normal! `<mlv`>mry"
    elseif a:type ==# 'char'
        exe "normal! `[mlv`]lmry"
    elseif a:type ==# 'line'
        exe "normal! `[ml0v`]$mry"
    else
        return
    endif
    set operatorfunc=MoveItOperator2
    call feedkeys("g@", "t")
endfunction

function! MoveItOperator2(type)
    let move_keys = ""
    if line("'[") < s:cursor_line
        let move_keys = "`[O"
    elseif line("']") > s:cursor_line
        let move_keys = "`]o"
    else
        return
    endif
    if a:type ==# 'line'
        exe "normal! " . move_keys . "\<esc>0Pmc"
    elseif a:type ==# 'char'
        exe "normal! " . move_keys . "\<esc>0Pmc"
    else
        return
    endif
    normal! `lv`rd
    if getline('.') ==# ''
        normal! dd
    endif
    normal! `c
    let @@ = s:reg_save
endfunction

function! CopyItOperator1(type)
    let s:reg_save = @@
    let s:cursor_line = line(".")
    if a:type ==# 'v'
        exe "normal! `<v`>y"
    elseif a:type ==# 'char'
        exe "normal! `[v`]ly"
    elseif a:type ==# 'line'
        exe "normal! `[0v`]$y"
    else
        return
    endif
    set operatorfunc=CopyItOperator2
    call feedkeys("g@", "t")
endfunction

function! CopyItOperator2(type)
    let move_keys = ""
    if line("'[") < s:cursor_line
        let move_keys = "`[O"
    elseif line("']") > s:cursor_line
        let move_keys = "`]o"
    else
        return
    endif
    if a:type ==# 'line'
        exe "normal! " . move_keys . "\<esc>0P"
    elseif a:type ==# 'char'
        exe "normal! " . move_keys . "\<esc>0P"
    else
        return
    endif
    let @@ = s:reg_save
endfunction

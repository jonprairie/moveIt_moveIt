nnoremap Mff :<c-u>set operatorfunc=MoveItForwardOperator<cr>0v$g@
nnoremap Mrr :<c-u>set operatorfunc=MoveItBackOperator<cr>0v$g@
nnoremap Mf  :set operatorfunc=MoveItForwardOperator<cr>g@
nnoremap MF  :set operatorfunc=MoveItForwardOperator<cr>g@
vnoremap Mf  :<c-u>call MoveItForwardOperator(visualmode())<cr>
vnoremap MF  :<c-u>call MoveItForwardOperator(visualmode())<cr>
nnoremap Mr  :set operatorfunc=MoveItBackOperator<cr>g@
nnoremap MR  :set operatorfunc=MoveItBackOperator<cr>g@
vnoremap Mr  :<c-u>call MoveItBackOperator(visualmode())<cr>
vnoremap MR  :<c-u>call MoveItBackOperator(visualmode())<cr>

nnoremap Mdd :<c-u>set operatorfunc=CopyItForwardOperator<cr>0v$g@
nnoremap Mee :<c-u>set operatorfunc=CopyItBackOperator<cr>0v$g@
nnoremap Md  :set operatorfunc=CopyItForwardOperator<cr>g@
nnoremap MD  :set operatorfunc=CopyItForwardOperator<cr>g@
vnoremap Md  :<c-u>call CopyItForwardOperator(visualmode())<cr>
vnoremap MD  :<c-u>call CopyItForwardOperator(visualmode())<cr>
nnoremap Me  :set operatorfunc=CopyItBackOperator<cr>g@
nnoremap ME  :set operatorfunc=CopyItBackOperator<cr>g@
vnoremap Me  :<c-u>call CopyItBackOperator(visualmode())<cr>
vnoremap ME  :<c-u>call CopyItBackOperator(visualmode())<cr>

function! MoveItForwardOperator(type)
    let s:reg_save = @@
    if a:type ==# 'v'
        exe "normal! `<mlv`>mry"
    elseif a:type ==# 'char'
        exe "normal! `[mlv`]lmry"
    elseif a:type ==# 'line'
        exe "normal! `[0mlv`]$mry"
    else
        return
    endif
    set operatorfunc=MoveItForwardOperator2
    call feedkeys("g@", "t")
endfunction

function! MoveItForwardOperator2(type)
    if a:type ==# 'line'
        exe "normal! `]o\<esc>0pmc"
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

function! MoveItBackOperator(type)
    let s:reg_save = @@
    if a:type ==# 'v'
        exe "normal! `<mlv`>mry"
    elseif a:type ==# 'char'
        exe "normal! `[mlv`]lmry"
    elseif a:type ==# 'line'
        exe "normal! `[0mlv`]$mry"
    else
        return
    endif
    set operatorfunc=MoveItBackOperator2
    call feedkeys("g@", "t")
endfunction

function! MoveItBackOperator2(type)
    if a:type ==# 'line'
        exe "normal! `[O\<esc>0pmc"
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

function! CopyItForwardOperator(type)
    let s:reg_save = @@
    if a:type ==# 'v'
        exe "normal! `<v`>y"
    elseif a:type ==# 'char'
        exe "normal! `[v`]ly"
    elseif a:type ==# 'line'
        exe "normal! `[0v`]$y"
    else
        return
    endif
    set operatorfunc=CopyItForwardOperator2
    call feedkeys("g@", "t")
endfunction

function! CopyItForwardOperator2(type)
    if a:type ==# 'line'
        exe "normal! `]o\<esc>0p"
    else
        return
    endif
    let @@ = s:reg_save
endfunction

function! CopyItBackOperator(type)
    let s:reg_save = @@
    if a:type ==# 'v'
        exe "normal! `<v`>y"
    elseif a:type ==# 'char'
        exe "normal! `[v`]ly"
    elseif a:type ==# 'line'
        exe "normal! `[0v`]$y"
    else
        return
    endif
    set operatorfunc=CopyItBackOperator2
    call feedkeys("g@", "t")
endfunction

function! CopyItBackOperator2(type)
    if a:type ==# 'line'
        exe "normal! `[O\<esc>0p"
    else
        return
    endif
    let @@ = s:reg_save
endfunction

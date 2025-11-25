nmap <C-b> ysiw2*<CR>
nmap <C-i> ysiw*
vmap <C-b> S2*<CR>
vmap <C-i> S*

set formatoptions+=ron


" ==== Custom text objects ====

" ---- Code Block Text Object ----
function! s:SelectACodeBlock()
    function! IsFence()
        return getline('.') =~ '^```'
    endfunction

    function! FencesAfterLine(line)
        return getline(line(a:line),'$')->filter({ _, v -> v =~ '^```'})->len()
    endfunction

    function! IsOpeningFence()
        return IsFence() && FencesBeforeLine('.') % 2 == 0
    endfunction

    function! IsClosingFence()
        return IsFence() && FencesBeforeLine('.') % 2 == 1
    endfunction

    function! IsBetweenFences()
        return synID(line("."), col("."), 0)->synIDattr('name') =~? 'markdownCodeBlock'
    endfunction

    if !IsBetweenFences()
        " Move to the opening fence
        call search('^```', 'W')
    endif

    if IsOpeningFence() || IsBetweenFences()
        " Move to the closing fence
        call search('^```', 'W')
    endif

    if IsClosingFence()
        call search('^```', 'Wbs')
        normal V''
        return 1
    endif

    " Implicitly return 0
endfunction

function! s:SelectInnerCodeBlock()
    if s:SelectACodeBlock()
        normal o+o-
    endif
endfunction

xnoremap <buffer> <silent> ac :<C-u>call <SID>SelectACodeBlock()<CR>
onoremap <buffer> <silent> ac :<C-u>call <SID>SelectACodeBlock()<CR>
xnoremap <buffer> <silent> ic :<C-u>call <SID>SelectInnerCodeBlock()<CR>
onoremap <buffer> <silent> ic :<C-u>call <SID>SelectInnerCodeBlock()<CR>

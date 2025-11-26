nmap <C-b> ysiw2*<CR>
nmap <C-i> ysiw*
vmap <C-b> S2*<CR>
vmap <C-i> S*

set formatoptions+=ron


" ==== Custom text objects ====

" ---- Code Block Text Object ----
function! s:SelectACodeBlock()
    let IsFence         = { x -> getline(x) =~ '^```' }
    let FencesUpTo      = { x -> getline(1,x)->filter("v:val=~'^```'")->len() }
    let IsOpeningFence  = { x -> IsFence(x) && FencesUpTo(x) % 2 == 1 }
    let IsClosingFence  = { x -> IsFence(x) && FencesUpTo(x) % 2 == 0 }
    let SynIDName       = { x -> synID(line(x),col(x), 0)->synIDattr('name') }
    let IsBetweenFences = { x -> SynIDName(x) =~? 'markdownCodeBlock' }

    if !IsBetweenFences('.')
        " Move to the opening fence
        call search('^```', 'W')
    endif

    if IsOpeningFence('.') || IsBetweenFences('.')
        " Move to the closing fence
        call search('^```', 'W')
    endif

    if IsClosingFence('.')
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


" ---- Heading section text object ----
" Selects content under the current heading, up to the next heading of the
" same or higher level

function! s:SelectASection()
    " Find last heading before cursor or return
    if !search('^#\{1,5\}\s', 'Wbc') | return | endif
    let l:current_level = getline('.')->matchstr('^#\{1,5\}\s')->len() - 1

    " Select up to to line before the next heading of same or higher level
    normal V
    if search('^#\{1,' . l:current_level . '}\s', 'W')
        normal -
    else
        normal G
    endif

    return 1
endfunction

function! s:SelectInnerSection()
    if s:SelectASection()
        normal o
        call search('^.', 'W')
        normal o
        call search ('.', 'Wb')
    endif
endfunction

xnoremap <buffer> <silent> ah :<C-u>call <SID>SelectASection()<CR>
onoremap <buffer> <silent> ah :<C-u>call <SID>SelectASection()<CR>
xnoremap <buffer> <silent> ih :<C-u>call <SID>SelectInnerSection()<CR>
onoremap <buffer> <silent> ih :<C-u>call <SID>SelectInnerSection()<CR>

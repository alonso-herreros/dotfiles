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
    let l:current_line = line('.')
    let l:current_level = 0

    let IsHeading = { x -> getline(x) =~# '^#\+\s' }
    " -1 if not a heading
    let HeadingLevel = { x -> getline(x)->matchstr('^#\+\s')->len() - 1 }

    " Determine current heading level
    let l:current_line = line('.')
    while !IsHeading(l:current_line) && l:current_line > 0
        let l:current_line -= 1
    endwhile
    let l:current_level = HeadingLevel(l:current_line)

    " If not inside a heading section
    if l:current_level < 0
        return
    endif

    " Move to the start of the section and start visual line mode
    execute l:current_line
    normal V

    " Move to line before the next heading of same or higher level
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

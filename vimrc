source $VIMRUNTIME/defaults.vim
language en_US.utf8
filetype plugin indent on

" Source .bash_aliases when running shell commands with :!
let $BASH_ENV = "~/.bash_aliases"

" Install vim-plug if needed
if empty(glob("~/.vim/autoload/plug.vim"))
  silent! execute '!curl --create-dirs -fsSLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * silent! PlugInstall
endif

call plug#begin()
Plug 'tomasiser/vim-code-dark'
Plug 'preservim/vim-indent-guides'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'wellle/targets.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/NERDTree', { 'on': 'NERDTreeToggle' }
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'obcat/vim-sclow'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'kshenoy/vim-signature'
Plug 'jasonccox/vim-wayland-clipboard'
Plug 'chrisbra/Colorizer'
Plug 'godlygeek/tabular'
Plug 'wellle/context.vim'
Plug 'fladson/vim-kitty'
call plug#end()

set t_Co=256
set t_ut=

syntax on
set tabstop=4 shiftwidth=4 expandtab

set nu rnu cul

if &term =~ 'xterm' || &term == 'win32'
    " Use DECSCUSR escape sequences
    let &t_SI .= "\e[5 q"  " blink bar
    let &t_SR .= "\e[3 q"  " blink underline
    let &t_EI .= "\e[1 q"  " blink block
    let &t_ti .= "\e[1 q"  " blink block
    let &t_te .= "\e[0 q"  " default (normally blink block)
elseif &term =~'screen'
    " Use DECSCUSR escape sequences
    let &t_SI .= "\eP\e[5 q\e\\"  " blink bar
    let &t_SR .= "\eP\e[3 q\e\\"  " blink underline
    let &t_EI .= "\eP\e[1 q\e\\"  " blink block
    let &t_ti .= "\eP\e[1 q\e\\"  " blink block
    let &t_te .= "\eP\e[0 q\e\\"  " default (normally blink block)
endif

set background=dark

let g:codedark_modern=1
let g:codedark_transparent=1
let g:airline_theme = 'codedark'
colorscheme codedark
hi DiffText term=bold cterm=bold ctermfg=188 ctermbg=25 guifg=#D4D4D4 guibg=#339ab2

let g:peekaboo_delay=1000
let g:peekaboo_compact=1

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ' |'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_section_z = '%#__accent_bold#%{g:airline_symbols.maxlinenr}%l : %v (%p%%)%#__restore__#'

" Context plugin
function IndentWithHeadings(line)
    let indent = indent(a:line)
    if indent < 0 | return [indent, indent] | endif

    let headings = match(getline(a:line), '^#\+\zs\s')+1
    if headings <= 0 | let headings = 6 | endif

    return [indent+headings, indent]
endfunction

let g:context_max_height = 8
let g:context_skip_regex = '^\s*\($\|//\|/\*\|\*\($\|/s\|\/\)\)'
let g:Context_indent = funcref("IndentWithHeadings")

" Remove mappings from context.vim, which conflict hard with my H
let g:context_add_mappings = 0

set showcmd                " Show (partial) command in status line.
set showmatch              " Show matching brackets.
set ignorecase             " Do case insensitive matching
set smartcase              " Do smart case matching
let g:sneak#use_ic_scs = 1 " Make Sneak use smartcase as well
set incsearch              " Incremental search
set autowrite              " Automatically save before commands like :next and :make
set hidden                 " Hide buffers when they are abandoned

set mouse=a                " Enable mouse usage (all modes)

set whichwrap+=h,l

" =====================================================================
" ========================     KEYBINDINGS     ========================
" =====================================================================
set to tm=1000 ttimeout ttm=50

let mapleader = " "

" This allows Alt-Key mappings, especially over ssh
set <A-q>=q
set <A-w>=w
set <A-e>=e
set <A-r>=r
set <A-i>=i
set <A-o>=o
set <A-a>=a
set <A-s>=s
set <A-d>=d
set <A-f>=f
set <A-g>=g
set <A-h>=h
set <A-j>=j
set <A-k>=k
set <A-l>=l
set <A-z>=z
set <A-x>=x
set <A-c>=c
set <A-v>=v
set <A-b>=b
set <A-n>=n
set <A-m>=m
set <A-Q>=Q
set <A-W>=W
set <A-E>=E
set <A-H>=H
set <A-J>=J
set <A-K>=K
set <A-L>=L
set <A-V>=V
set <A-B>=B
set <A-M>=M
set <A-`>=`

" ======= PLUGIN MAPPINGS =======
" Sneak-f
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
" Sneak ,;
map , <Plug>Sneak_;
map ; <Plug>Sneak_,
" Align
nmap <A-a> <Plug>(EasyAlign)ip
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
nmap <A-a> <Plug>(EasyAlign)ip
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
" Commentary with Ctrl+ç
nmap  m`gcc``
nmap <C-ç> m`gcc``
vmap  gc
vmap <C-ç> gc
imap  <C-o>m`gcc``
imap <C-ç> <C-o>m`gcc``
" Tabular with Ctrl+t
" noremap <C-t> :Tab/
" fzf Files with C-S-e
nmap <C-E> :Files<CR>


" ======= GENERAL MAPPINGS =======
" Save with C-s, sudo save with C-A-s
map  <C-s>   :w<CR>
map! <C-s>   <Esc>:w<CR>
map  <C-A-s> :w!!<CR>
map! <C-A-s> <Esc>:w!!<CR>
" Ctrl-F to search
noremap <C-f> /
noremap <C-h> :%s/\v
" Ctrl-A to select all
noremap <C-a> <Esc>ggvG$
" Increment and decrement
noremap <C-+> <C-a>
noremap <C-_> <C-x>
" Yank to clipboard
map <Leader>y "+y
map <Leader>Y "+Y
" Put, delete and change from/to yank register
map <Leader>p "0p
map <Leader>P "0P
map <Leader>d "0d
map <Leader>D "0D
map <Leader>c "0c
map <Leader>C "0C
" Quick use: q macro and m marker
noremap Q @q
noremap M `m
" Redo with U
noremap U <C-r>
" Buffers with Alt+h/l or Ctrl+(Shift)+Tab, as they're the most 'tab'-like
noremap <A-l> :bn<CR>
noremap <A-h> :bN<CR>
map <C-Tab> :bn<CR>
map <C-S-Tab> :bN<CR>
" Tabs with (Shift)+Tab. Not normally used in other programs, but useful here.
noremap <Tab> gt
noremap <S-Tab> gT
" Split manipulation with Ctrl+Alt+key (Not used enough to need Ctrl+key)
noremap <C-A-h> <C-w>h
noremap <C-A-j> <C-w>j
noremap <C-A-k> <C-w>k
noremap <C-A-l> <C-w>l
noremap <C-A-LT> <C-w><LT>
"! noremap <C-A->> <C-w>> (doesn't work, switch split and use the above)
noremap <C-A-+> <C-w>+
noremap <C-A-_> <C-w>-
noremap! <C-A-h> <C-w>h
noremap! <C-A-j> <C-w>j
noremap! <C-A-k> <C-w>k
noremap! <C-A-l> <C-w>l
noremap! <C-A-LT> <C-w><LT>
noremap! <C-A-+> <C-w>+
noremap! <C-A-_> <C-w>-


" ======= NORMAL MODE MAPPINGS =======
" HJKL: 10-fold j/k & Beginning/end of line
nnoremap J 10gjzz
nnoremap K 10gkzz
nnoremap H ^
nnoremap L $
" Yank-to-end like C and D
nnoremap Y y$
" Moving and duplicating lines
nnoremap <A-j> ddp
nnoremap <A-J> yyp
nnoremap <A-k> ddkP
nnoremap <A-K> yyP
" Joining lines without taking J
nnoremap <C-j> J
nnoremap g<C-j> gJ
" Adding spaces, lines and line breaks
nnoremap <Leader>i i<Space><Esc>l
nnoremap <Leader>a a<Space><Esc>h
nnoremap <Leader>o m`o<Esc>0D``
nnoremap <Leader>O m`O<Esc>0D``
nnoremap <Leader><CR> cl<CR><Esc>
" Overwrite with yanked
nmap <Leader>R R<C-r>0<Esc>
" Save/quit with leader->key
nmap <Leader>w :w<CR>
nmap <Leader>W :w!!<CR>
nmap <Leader>q :q!<CR>
nmap <Leader>e :e!<CR>
nmap <Leader>z :wq<CR>
nmap <Leader>x :bd<CR>
" Inspect character
nnoremap gi ga
nnoremap g? ga
" Reflow with Alt+q (due to VSCode reflow shortcut)
nnoremap <A-q> gwip

" ======= OP-PENDING MODE MAPPINGS =======
" Beginning/end of line with H/L
onoremap H ^
onoremap L $

" ======= VISUAL MODE MAPPINGS =======
" Visual easy exit
vnoremap ñ <Esc>
" Visual mode will use visual j/k
vnoremap j gj
vnoremap k gk
" HJKL: 10-fold j/k & Beginning/end of line
vnoremap J 10gj
vnoremap K 10gk
vnoremap H ^
vnoremap L $h
" Moving multiple lines
vnoremap <A-j> dpgv`[o`]
vnoremap <A-k> dkPgv`[o`]
" Indenting while keeping selection
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
vnoremap > >gv
vnoremap < <gv
" Reflow with Alt+q (due to VSCode reflow shortcut)
vnoremap <A-q> gw

" ======= INSERT MODE MAPPINGS =======
" Since Ctrl+z in insert mode doesn't do anything useful, let it... do this
inoremap <C-z> <C-u>
" Ctrl+backspace/delete
inoremap <C-Backspace> <C-w>
inoremap <C-Delete> <C-o>de
" Back-tabbing
inoremap <S-Tab> <C-d>
" Easy exit, kj to the left and jk to the right
inoremap kj <Esc>
inoremap KJ <Esc>
inoremap jk <Esc>l
inoremap JK <Esc>l
" Line-enders - not that useful in my experience
" inoremap ;; <C-o>$;
" Newlines
inoremap <S-CR> <Esc>O
inoremap <A-o> <Esc>o
inoremap <A-O> <Esc>O
" hjkl moving
inoremap <A-h> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <A-l> <Right>
" TODO: fix wbe moving in insert mode
" inoremap <A-w> <C-o>w
" inoremap <A-e> <C-Right>
" inoremap <A-b> <C-o>b
" Quick markers
inoremap <A-m> <C-o>m`
inoremap <A-`> <C-o>``
" Beginning/end of line moving
inoremap <A-i> <C-o>^
inoremap <A-a> <Esc>A
" Visual from Insert
inoremap <A-H> <C-o>vh
inoremap <A-J> <C-o>vj
inoremap <A-K> <C-o>vk
inoremap <A-L> <C-o>vl
inoremap <A-v> <C-o>v
" Joining lines with Ctrl+j
inoremap <C-j> <C-o>J
" Reflow with Alt+q (due to VSCode reflow shortcut)
inoremap <A-q> <C-o>gwip

" imap <expr> <Tab> pumvisible() ? '<C-y>' : '<Tab>'
imap <expr> <Tab> (getline('.')[col('.')-2] !~ '^\s\?$' \|\| pumvisible())
      \ ? '<C-y>' : '<Tab>'

" ======= COMMAND MODE MAPPINGS =======
" Sudo write
cmap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Use very magic. Commands swapped because I use %s more.
" UPDATE: cnoremap breaks shit because 's/' is replaced everywhere,
" including paths
" cnoremap s/ %s/\v
" cnoremap %s/ s/\v
command! -nargs=1 S %s/\v<args>

" cnoreabbr tree NERDTree



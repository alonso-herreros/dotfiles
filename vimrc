source $VIMRUNTIME/defaults.vim
language en_US.utf8
filetype plugin indent on

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
Plug 'justinmk/vim-sneak'
Plug 'wellle/targets.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/NERDTree', { 'on': 'NERDTreeToggle' }
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/vim-peekaboo'
Plug 'airblade/vim-gitgutter'
Plug 'obcat/vim-sclow'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'kshenoy/vim-signature'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jasonccox/vim-wayland-clipboard'
Plug 'chrisbra/Colorizer'
call plug#end()

set t_Co=256
set t_ut=

syntax on
set tabstop=4 shiftwidth=4 expandtab

set nu rnu cul

if &term =~ "xterm"
    let &t_SI = "\<Esc>]12;purple\x7"
    let &t_SR = "\<Esc>]12;red\x7"
    let &t_EI = "\<Esc>]12;blue\x7"
endif

if &term =~ 'xterm' || &term == 'win32'
" Use DECSCUSR escape sequences
    let &t_SI = "\e[5 q"    " blink bar
    let &t_SR = "\e[3 q"    " blink underline
    let &t_EI = "\e[1 q"    " blink block
    let &t_ti ..= "\e[1 q"  " blink block
    let &t_te ..= "\e[0 q"  " default (depends on terminal, normally blink block)
endif

set background=dark

let g:codedark_modern=1
let g:codedark_transparent=1
let g:airline_theme = 'codedark'
colorscheme codedark

let g:peekaboo_delay=300
let g:peekaboo_compact=1

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ' |'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_section_z = '%#__accent_bold#%{g:airline_symbols.maxlinenr}%l : %v (%p%%)%#__restore__#'

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
let g:sneak#use_ic_scs = 1 " Make Sneak use smartcase as well
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned

set mouse=a		" Enable mouse usage (all modes)

set whichwrap+=h,l

" =====================================================================
" ========================     KEYBINDINGS     ========================
" =====================================================================
set to tm=1000 ttimeout ttm=50

let mapleader = " "

" This allows Alt-Key mappings
set <A-h>=h
set <A-H>=H
set <A-j>=j
set <A-J>=J
set <A-k>=k
set <A-K>=K
set <A-l>=l
set <A-L>=L
set <A-e>=e
set <A-E>=E
set <A-b>=b
set <A-B>=B
set <A-w>=w
set <A-W>=W
set <A-v>=v
set <A-V>=V
set <A-i>=i
set <A-a>=a
set <A-m>=m
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
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" Commentary with Ctrl+ç
nmap  m`gcc``
nmap <C-ç> m`gcc``
vmap  gc
vmap <C-ç> gc
imap  <C-o>gcc
imap <C-ç> <C-o>gcc
" fzf Files with C-S-e
nmap <C-E> :Files<CR>


" ======= GENERAL MAPPINGS =======
" Save with C-s, sudo save with C-A-s
noremap <C-s> :w<CR>
noremap <C-A-s> :w!!<CR>
noremap! <C-s> <Esc>:w<CR>
noremap! <C-A-s> <Esc>:w!!<CR>
" Ctrl-F to search
noremap <C-f> /
noremap <C-h> :%s/\v
" Ctrl-A to select all
noremap <C-a> <Esc>ggvG$
" Increment and decrement
noremap <C-+> <C-a>
noremap <C-_> <C-x>
" Yank to w register and clipboard
map <Leader>y "+y
map <Leader>Y "+Y
" Put and delete from/to yank register
map <Leader>p "0p
map <Leader>P "0P
map <Leader>d "0d
map <Leader>D "0D
" Quick use: q macro and m marker
noremap Q @q
noremap M `m
" Yank-to-end like C and D
noremap Y y$
" Redo with U
noremap U <C-r>
" Tab moving with Alt+h/l (matching my vimium config)
noremap <A-l> gt
noremap <A-h> gT
noremap! <A-l> gt
noremap! <A-h> gT
" Split moving with C-A-hjkl (not used enough to need C-hjkl)
noremap <C-A-h> <C-w>h
noremap <C-A-j> <C-w>j
noremap <C-A-k> <C-w>k
noremap <C-A-l> <C-w>l
noremap! <C-A-h> <C-w>h
noremap! <C-A-j> <C-w>j
noremap! <C-A-k> <C-w>k
noremap! <C-A-l> <C-w>l

" ======= NORMAL MODE MAPPINGS =======
" HJKL: 10-fold j/k & Beginning/end of line
nnoremap J 10gjzz
nnoremap K 10gkzz
nnoremap H ^
nnoremap L $
" Moving and duplicating lines
nnoremap <A-j> ddp
nnoremap <A-J> yyp
nnoremap <A-k> ddkP
nnoremap <A-K> yyP
" Joining lines without taking J
nnoremap <C-j> J
nnoremap g<C-j> gJ
" Save/quit with leader->key
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>z :wq<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>W :w!!<CR>
" Adding spaces, lines and line breaks
nnoremap <Leader>i i<Space><Esc>l
nnoremap <Leader>a a<Space><Esc>h
nnoremap <Leader>o m`o<Esc>0D``
nnoremap <Leader>O m`O<Esc>0D``
nnoremap <Leader><CR> cl<CR><Esc>
" Tabs with Tab
nnoremap <Tab> gt
nnoremap <S-Tab> gT

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

" ======= INSERT MODE MAPPINGS =======
" Ctrl+backspace/delete
inoremap <C-Backspace> <C-w>
inoremap <C-Delete> <C-o>de
" Easy exit, optionally saving
inoremap kj <Esc>
inoremap KJ <Esc>
inoremap jk <Esc>:w<Return>
inoremap JK <Esc>:w<Return>
" Line-enders
inoremap ;; <C-o>$;
" Newlines
inoremap <S-CR> <Esc>O
inoremap <A-o> <Esc>o
inoremap <A-O> <Esc>O
" hjkl moving
inoremap <A-h> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <A-l> <Right>
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

" ======= COMMAND MODE MAPPINGS =======
" Sudo write. Recursive so i can use it in other mappings
cmap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Use very magic. Commands swapped because I use %s more.
" UPDATE: cnoremap breaks shit because 's/' is replaced everywhere,
" including paths
" cnoremap s/ %s/\v
" cnoremap %s/ s/\v
command! -nargs=1 S %s/\v<args>

cnoreabbr tree NERDTree



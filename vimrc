" Minimal vimrc without plugins intended for root and remote systems

" Enable syntax highlighting and load indentation rules and plugins
syntax on
filetype plugin indent on

" Options
set nocompatible
set nomodeline
set showcmd
set showmatch
set wildmenu
set clipboard=unnamedplus
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set backspace=indent,eol,start
set ignorecase
set smartcase
set incsearch
set hlsearch
set splitbelow
set splitright
set background=dark
set encoding=utf8
set scrolloff=5
set wrap linebreak
set number relativenumber
set gdefault

" Statusline settings
set laststatus=2
set statusline+=\ %f
set statusline+=\ %m
set statusline+=\ %r
set statusline+=%=
set statusline+=\ \ %y
set statusline+=\ \ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ \ %l:%c
set statusline+=\ \ %p%%
set statusline+=\ 
hi StatusLine cterm=NONE ctermbg=237

" Use space as leader key
let mapleader="\<space>"
let maplocalleader="\<space>"


" The following keybindings are adapted to a modified VOU layout
" and mostly won't make sense on a default QWERTY/QWERTZ keyboard

" Joining, replacing and redo
nnoremap ö J
nnoremap ü r
vnoremap ü r
nnoremap ä <c-r>

" Switching to insert mode
nnoremap r i
nnoremap w A
nnoremap l o
nnoremap L O
vnoremap r I
vnoremap w A

" Navigating the jump list
nnoremap <c-k> <c-o>
nnoremap <c-m> <c-i>

" Changing the selection area
vnoremap l o
vnoremap L O

" Deleting last word using <C-BS>
noremap! <c-bs> <c-w>
noremap! <c-h> <c-w>

" Movement
nnoremap A b
nnoremap I w
nnoremap O <c-u>
nnoremap E <c-d>
nnoremap a h
nnoremap e gj
nnoremap o gk
nnoremap i l
vnoremap A b
vnoremap I w
vnoremap O <c-u>
vnoremap E <c-d>
vnoremap a h
vnoremap e gj
vnoremap o gk
vnoremap i l

" Macros
nnoremap Q q

" Saving and quitting
nnoremap <leader>s :update<cr>
nnoremap q :q<cr>
nnoremap <leader>q :qa<cr>

" Searching and substituting
nnoremap j /
nnoremap h *
nnoremap H :%s/
nnoremap <leader>j :noh<cr>
vnoremap j /
vnoremap h "hy/<c-r>h<cr>
vnoremap H :s/

" Jumping and command-line mode
nnoremap k '
nnoremap kk ''
nnoremap _ :
vnoremap k '
vnoremap kk ''
vnoremap _ :

" Yanking to end of line or the buffer
nnoremap Y y$
nnoremap <leader>y :%y<cr>

" Spell checking
nnoremap Z z=
nnoremap <leader>z :setlocal invspell<cr>

" Window management
nnoremap <c-a> <c-w>h
nnoremap <c-e> <c-w>j
nnoremap <c-o> <c-w>k
nnoremap <c-i> <c-w>l

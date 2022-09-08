" Minimal vimrc without plugins intended for root and remote systems

" Enable syntax highlighting and load indentation rules and plugins
syntax on
filetype plugin indent on

" Move temporary files to a secure location to protect against CVE-2017-1000382
if exists('$XDG_CACHE_HOME')
  let &g:directory=$XDG_CACHE_HOME
else
  let &g:directory=$HOME . '/.cache'
endif
let &g:undodir=&g:directory . '/vim/undo//'
let &g:backupdir=&g:directory . '/vim/backup//'
let &g:directory.='/vim/swap//'

" Create directories if they doesn't exist
if ! isdirectory(expand(&g:directory))
  silent! call mkdir(expand(&g:directory), 'p', 0700)
endif
if ! isdirectory(expand(&g:backupdir))
  silent! call mkdir(expand(&g:backupdir), 'p', 0700)
endif
if ! isdirectory(expand(&g:undodir))
  silent! call mkdir(expand(&g:undodir), 'p', 0700)
endif

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
set scrolloff=3
set wrap linebreak
set number relativenumber

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

" Replacing
nnoremap ü r
nnoremap ö R
vnoremap ü r
vnoremap ö R

" Switching to insert mode
nnoremap r i
nnoremap w A
nnoremap l o
nnoremap L O
vnoremap r I
vnoremap w A
vnoremap l o

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

" Saving and quittinq
nnoremap <leader>s :update<cr>
nnoremap q :q<cr>
nnoremap <leader>q :qa<cr>

" Searching and jumping
nnoremap _ :
nnoremap j /
nnoremap k `
nnoremap kk ``
nnoremap <leader>j :noh<cr>

" Search/replace word under cursor/selection
nnoremap h *
nnoremap H :%s/\<<c-r><c-w>\>//g<left><left>
vnoremap h "hy/<c-r>h<cr>
vnoremap H "hy:%s/<c-r>h//g<left><left>

" Yank to end of line and buffer
nnoremap Y y$
nnoremap <leader>y :%y<cr>

" Delete not into register with x (use dl for cutting one character into register)
nnoremap x "_x

" Redo
nnoremap ä <c-r>

" Switching between buffers
nnoremap <c-v> :bp<cr>
nnoremap <c-u> :bn<cr>

" Spell checking
nnoremap Z z=
nnoremap <leader>z :setlocal invspell<cr>

" Window management
nnoremap <c-a> <c-w>h
nnoremap <c-e> <c-w>j
nnoremap <c-o> <c-w>k
nnoremap <c-i> <c-w>l
nnoremap <leader>a :to vs %<cr>
nnoremap <leader>e :sp<cr>
nnoremap <leader>o :to sp %<cr>
nnoremap <leader>i :vs<cr>

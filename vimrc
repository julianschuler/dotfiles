" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" jump to last position after reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" enable syntax highlighting and load indentation rules and plugins
syntax on
filetype plugin indent on

" use space as leader key
let mapleader="\<space>"
let maplocalleader="\<space>"

" plugins
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'easymotion/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'lervag/vimtex'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'dense-analysis/ale'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
call plug#end()

" delimitMate settings
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_jump_expansion = 1

" easymotion settings
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = "EITRNSOUGLHYDWMAC"

" Gruvbox settings
let g:gruvbox_guisp_fallback = "bg"
autocmd vimenter * ++nested colorscheme gruvbox

" vimtex settings
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '/tmp',
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_ignore_filters = [ 'Warning: You have requested package' ]
if empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('VIM')
endif

" ale settings
let g:ale_linters = {
    \ 'javascriptreact': ['eslint'],
    \ 'python': ['flake8'],
    \}
let g:ale_fixers = {
    \ 'javascriptreact': ['eslint'],
    \ 'python': ['black', 'isort'],
    \ }
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_change = 'never'
let g:ale_linters_explicit = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

" Open markdown preview when entering markdown buffer
let g:mkdp_auto_start = 1

set showcmd                     " show command in bottom bar
set cursorline                  " highlight current line
set showmatch                   " highlight matching [{()}]
set wildmenu                    " visual autocomplete for command menu
set clipboard=unnamedplus       " copy to system clipboard

set tabstop=4                   " number of visual spaces per TAB
set softtabstop=4               " number of spaces in tab when editing
set shiftwidth=4                " 1 tab == 4 spaces
set expandtab                   " tabs are spaces
set autoindent                  " indent new lines
set backspace=indent,eol,start  " always delete previous words

set ignorecase                  " make search case-insensitive by default (word\C → case sens.)
set smartcase                   " make search case-sensitive if word contains uppercase letter
set incsearch                   " search as characters are entered
set hlsearch                    " highlight matches
set splitbelow                  " open splits below
set splitright                  " open vsplits right

set background=dark             " setting dark mode
set encoding=utf8               " set encoding to utf8
set scrolloff=3                 " always show at least 3 lines above and below the cursor
set wrap linebreak              " wrap long lines without splitting words
set directory=/tmp              " write swap files to /tmp

set laststatus=2
set statusline=
set statusline+=
set statusline+=%{FugitiveStatusline()}
set statusline+=%#CursorColumn#
set statusline+=\ %f
set statusline+=\ %m
set statusline+=\ %r
set statusline+=%=
" set statusline+=\ %y
set statusline+=\ Line:\ %l/%L
set statusline+=\ (%p%%)
set statusline+=\ Col:\ %c
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ 

" enable number hybrid mode with focus
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END


" The following keybindings are adapted to a modified VOU layout
" and mostly won't make sense on a default QWERTY/QWERTZ keyboard

" replacing
nnoremap ü r
nnoremap ö R
vnoremap ü r
vnoremap ö R

" switching to insert mode
nnoremap r i
nnoremap w A
nnoremap l o
nnoremap L O
vnoremap r I
vnoremap w A
vnoremap l o
vnoremap h O

" delete last word using <C-BS>
noremap! <c-bs> <c-w>
noremap! <c-h> <c-w>

" movement
nnoremap A b
nnoremap I w
nnoremap O 7<c-y>
nnoremap E 7<c-e>
" nnoremap O 7gk
" nnoremap E 7gj
nnoremap a h
nnoremap e gj
nnoremap o gk
nnoremap i l
vnoremap A b
vnoremap I w
vnoremap O 7<c-y>
vnoremap E 7<c-e>
vnoremap a h
vnoremap e gj
vnoremap o gk
vnoremap i l

" saving and quittinq
nnoremap <leader>s :update<cr>
nnoremap q :q<cr>

" searching and jumping
nnoremap _ :
nnoremap j /
nnoremap J :Rg 
nnoremap k `
nnoremap kk ``
nnoremap <leader>j :noh<cr>
nnoremap h *
nnoremap H :%s/\<<C-r><C-w>\>//g<Left><Left>

" yank to end of line
nnoremap Y y$

" yank file to system clipboard
nnoremap <leader>c :w !xclip -selection c<cr><cr>

" delete not into register with x (use dl for cutting one character into register)
nnoremap x "_x

" redo
nnoremap ä <c-r>

" use v to enter visual block mode
nnoremap v <c-v>

" swap ; and , (next/previous match after t, T, f, F)
nnoremap ; ,
nnoremap , ;
vnoremap ; ,
vnoremap , ;

" easymotion bindings
nmap s <Plug>(easymotion-s)
nmap W <Plug>(easymotion-w)

map <c-i> <Plug>(easymotion-lineforward)
map <c-a> <Plug>(easymotion-linebackward)
map <c-o> <Plug>(easymotion-k)
map <c-e> <Plug>(easymotion-j)

" find files with fzf
nnoremap f :GFiles<cr>
nnoremap F :Files<cr>
nnoremap <leader>f :Files $HOME<cr>

" switching between buffers
nnoremap <c-v> :bp<cr>
nnoremap <c-u> :bn<cr>
nnoremap b :Buffers<cr>

" Open :Git
nnoremap <leader>g :Git

" yank, delete or select line without line break
nnoremap yal 0y$
nnoremap yil ^yg_
nnoremap dal 0d$
nnoremap dil ^dg_
nnoremap val 0v$
nnoremap vil ^vg_

" spell checking
nnoremap z z=

" YCM bindings
nnoremap <leader>t :YcmCompleter GoTo<cr>
nnoremap <leader>r :YcmCompleter GoToReferences<cr>
nnoremap <leader>n :YcmCompleter GoToDefinition<cr>
" nnoremap <leader>f :YcmCompleter FixIt<cr>

" window management
nnoremap <leader>a <c-w>h
nnoremap <leader>e <c-w>j
nnoremap <leader>o <c-w>k
nnoremap <leader>i <c-w>l
nnoremap <leader>A :to vs %<cr>
nnoremap <leader>E :sp<cr>
nnoremap <leader>O :to sp %<cr>
nnoremap <leader>I :vs<cr>

" terminal management
nnoremap <leader>u :vert term<cr>
tnoremap <c-n> <c-w>N
tnoremap <c-a> <c-w>h
tnoremap <c-e> <c-w>j
tnoremap <c-o> <c-w>k
tnoremap <c-i> <c-w>l

" let $VIM = $HOME . "/vim"
" let $VIMRUNTIME = $HOME . "/vim/runtime"
" set runtimepath^=$VIMRUNTIME
" set helpfile=$VIMRUNTIME/doc/help.txt

set nocompatible

filetype plugin indent on
syntax on

set encoding=utf-8

set termguicolors
set softtabstop=4
set tabstop=4
set shiftwidth=0	
set noexpandtab
set showmatch
set number
set ruler
set relativenumber

set statusline+=%F
set laststatus=2

set splitright
set splitbelow

set foldcolumn=2
set foldmethod=syntax

set noerrorbells

set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*

command! W w

set backspace=indent,eol,start

set background=dark
colorscheme habamax


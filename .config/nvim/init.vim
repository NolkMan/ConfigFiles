"call plug#begin('~/.config/nvim/autoload/plug.vim')
call plug#begin()

Plug 'Valloric/YouCompleteMe', { 'do' : 'python3 ./install.py --clang-completer --clangd-completer --java-completer --go-completer --ts-completer --rust-completer'}
Plug 'scrooloose/nerdtree'
Plug 'flazz/vim-colorschemes'
"Plug 'neomake/neomake'

call plug#end()

filetype plugin indent on
syntax on

set encoding=utf-8

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

set hlsearch
set noerrorbells
set belloff=all

set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*

command! W w

set backspace=indent,eol,start

set background=dark
colorscheme gruvbox
set guifont=Fira\ Mono\ 8


set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

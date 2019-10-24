let $VIM = $HOME . "/vim"
let $VIMRUNTIME = $HOME . "/vim/runtime"
set runtimepath^=$VIMRUNTIME
set helpfile=$VIMRUNTIME/doc/help.txt


set nocompatible
" if has('gui_running')
	filetype off                  " required
	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()

	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'

	Plugin 'Shougo/vimproc.vim'
	Plugin 'Valloric/YouCompleteMe'
	Plugin 'vim-syntastic/syntastic'
	Plugin 'flazz/vim-colorschemes'
"	Plugin 'scrooloose/nerdtree'
"	Plugin 'jiangmiao/auto-pairs'
	Plugin 'rhysd/vim-clang-format'
"	Plugin 'neovimhaskell/haskell-vim'
	call vundle#end()            " required
" endif

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
" set belloff=all

set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*

command! W w

set backspace=indent,eol,start

noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

"	autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
"	autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

	set background=dark
	let g:gruvbox_contrast_dark = 'hard'
	set guifont=Fira_Mono:h10
	colorscheme gruvbox

"	map! <C-[> :YcmCompleter GoToImprecise<LF>
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*

	let g:ycm_show_diagnostics_ui = 0
	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_check_on_open = 1
	let g:syntastic_check_on_wq = 0
	let g:syntastic_aggregate_errors = 1
	let g:syntastic_cpp_checkers = [ 'gcc' ] " , 'clang_check', 'clang_tidy' ]
	let g:syntastic_cpp_compiler_options = " -std=c++14 -Iinclude -Isrc"
	let g:syntastic_cpp_include_dirs = ["include", "src"]
	let g:syntastic_cpp_clang_post_args = ""

	let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
	let g:ycm_key_list_select_completion = ['<TAB>']
	let g:ycm_key_list_previous_completion = ['<S-TAB>']
	let g:ycm_key_list_stop_completion = ['<C-c>', '<UP>', '<DOWN>']
	" let g:ycm_autoclose_preview_window_after_completion = 0

	let NERDTreeRespectWildIgnore=1

	let g:clang_format#detect_style_file=1

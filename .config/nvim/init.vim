let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion = ['<S-TAB>']
let g:ycm_key_list_stop_completion = ['<C-c>', '<UP>', '<DOWN>']

let NERDTreeRespectWildIgnore=1

let g:clang_format#detect_style_file=1

"call plug#begin('~/.config/nvim/autoload/plug.vim')
call plug#begin()

Plug 'Valloric/YouCompleteMe', { 'do' : 'python3 ./install.py --clangd-completer --ts-completer --rust-completer'}
Plug 'scrooloose/nerdtree'
"Plug 'flazz/vim-colorschemes'
"Plug 'jelera/vim-javascript-syntax'
Plug 'sainnhe/gruvbox-material'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
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

set hlsearch
set noerrorbells
set belloff=all

set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*

command! W w

set backspace=indent,eol,start

set statusline+=%#warningmsg#
set statusline+=%*

set mouse=
set guicursor=
set whichwrap=s,b

set list listchars=tab:\ \ ,trail:_,nbsp:+

if has('termguicolors')
  set termguicolors
endif

let g:gruvbox_material_better_performance = 1
" Set contrast.
" This configuration option should be placed before `colorscheme gruvbox-material`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'hard'

set background=dark
colorscheme gruvbox-material
set guifont=Fira\ Mono\ 8

set foldcolumn=2
"set foldmethod=syntax
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "cpp", "make", "javascript", "json", "python", "lua", "vim", "vimdoc"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,
	-- vim.api.nvim_set_hl(0, "@variable", { link = "Operator" }),
	-- vim.api.nvim_set_hl(0, "@reference", { link = "Operator" }),

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF


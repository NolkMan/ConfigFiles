vim.opt.guicursor = ""

vim.opt.number = true
vim.opt.ruler = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = false

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "no"

vim.opt.updatetime = 50

vim.opt.statusline:append("%F%#warningmsg#%*")
vim.opt.laststatus = 2

vim.opt.background = "dark"
vim.opt.guifont = "Fira Mono 8"

vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 2
-- vim.opt.foldmethod=expr
-- vim.opt.foldexpr=nvim_treesitter#foldexpr()

vim.opt.backspace = "indent,eol,start"

vim.opt.mouse = ""
vim.opt.whichwrap = "s,b"




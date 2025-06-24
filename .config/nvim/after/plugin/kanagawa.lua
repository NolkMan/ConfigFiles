vim.o.background = 'dark' -- or "light" for light mode

require('kanagawa').setup({
	theme = "dragon", -- wave, dragon, lotus
	background = {
		dark = "dragon",
		light = "wave",
	}
})

vim.cmd([[colorscheme kanagawa]])

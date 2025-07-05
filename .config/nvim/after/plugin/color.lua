vim.o.background = 'dark' -- or "light" for light mode

function Color(opts)
	print(opts.fargs[1])
    local color = opts.fargs[1] or 'kanagawa'
	if color:lower():match("tok") then
		color = "tokyonight"
	end
	vim.cmd([[colorscheme ]] .. color)

end


require('kanagawa').setup({
	theme = "dragon", -- wave, dragon, lotus
	background = {
		dark = "dragon",
		light = "wave",
	}
})

require("tokyonight").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	style = "night",                    -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	transparent = false,                -- Enable this to disable setting the background color
	terminal_colors = true,             -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = false },
		keywords = { italic = false },
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "dark",             -- style for sidebars, see below
		floats = "dark",               -- style for floating windows
	},
})

vim.cmd([[colorscheme tokyonight-night]])

vim.api.nvim_create_user_command('Light', 'set background=light', {})
vim.api.nvim_create_user_command('Dark', 'set background=dark', {})

vim.api.nvim_create_user_command('Color', Color, {nargs = 1})


vim.o.background = 'dark'

vim.api.nvim_create_user_command('Light', 'set background=light', {})
vim.api.nvim_create_user_command('Dark', 'set background=dark', {})

return {
	{
		'rebelot/kanagawa.nvim',
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		opts = {
			theme = "dragon", -- wave, dragon, lotus
			background = {
				dark = "dragon",
				light = "wave",
			}
		},
		config = function()
			-- load the colorscheme here
			vim.cmd.colorscheme('kanagawa-dragon')
		end,
	},
	{
		'folke/tokyonight.nvim',
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
			transparent = false, -- Enable this to disable setting the background color
			terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
			styles = {
				-- Style to be applied to different syntax groups
				-- Value is any valid attr-list value for `:help nvim_set_hl`
				comments = { italic = false },
				keywords = { italic = false },
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "dark", -- style for sidebars, see below
				floats = "dark", -- style for floating windows
			},
		},
	},
}

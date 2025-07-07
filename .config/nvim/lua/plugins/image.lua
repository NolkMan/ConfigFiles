return {
	"3rd/image.nvim",
	opts = {
		build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
		backend = "ueberzug",
		processor = "magick_cli",
		max_height_window_percentage = 25,
	}
}

require 'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = { "javascript", "json", "python", "lua", "vim", "vimdoc", "markdown" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	highlight = {
		enable = true,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
}

--[[
local function get_custom_foldtxt_suffix(foldstart)
  local fold_suffix_str = string.format(
    "  %s [%s lines]",
    '┉',
    vim.v.foldend - foldstart + 1
  )

  return { fold_suffix_str, "Folded" }
end

local function get_custom_foldtext(foldtxt_suffix, foldstart)
  local line = vim.api.nvim_buf_get_lines(0, foldstart - 1, foldstart, false)[1]

  return {
    { line, "Normal" },
    foldtxt_suffix
  }
end

_G.get_foldtext = function()
  local foldstart = vim.v.foldstart
  local ts_foldtxt = vim.treesitter.foldtext()
  local foldtxt_suffix = get_custom_foldtxt_suffix(foldstart)

  if type(ts_foldtxt) == "string" then
    return get_custom_foldtext(foldtxt_suffix, foldstart)
  else
    table.insert(ts_foldtxt, foldtxt_suffix)
    return ts_foldtxt
  end
end
]]

-- vim.opt.foldtext = "v:lua.get_foldtext()"

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"

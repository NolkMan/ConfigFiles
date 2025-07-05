local M = {}

M.namespace = vim.api.nvim_create_namespace "nolkman_markdown_namespace"
local q = require "vim.treesitter.query"

M.config = {
	markdown = {
		query = vim.treesitter.query.parse(
			"markdown",
			[[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] (inline) @headline)
            ]]
		),
	},
}

M.setup = function(config)
	config = config or {}
	M.config = vim.tbl_deep_extend("force", M.config, config)

	-- tbl_deep_extend does not handle metatables
	for filetype, conf in pairs(config) do
		if conf.query then
			M.config[filetype].query = conf.query
		end
	end

	-- vim.cmd [[ highlight default link Todo ColorColumn ]] -- defined in color scheme
	vim.cmd [[ highlight default link Warn ColorColumn ]]
	vim.cmd [[ highlight default link Erro ColorColumn ]]
	vim.cmd [[ highlight default link Done ColorColumn ]]

	vim.cmd [[highlight Done guibg=#ABED7D guifg=#000000]]
	vim.cmd [[highlight Warn guibg=#FEAF7F guifg=#000000]]
	vim.cmd [[highlight Erro guibg=#EF6461 guifg=#000000]]

	vim.cmd [[
        augroup Markdown
        autocmd FileChangedShellPost,Syntax,TextChanged,InsertLeave,WinScrolled * lua require('nolkman.markdown').refresh()
        augroup END
    ]]
end

local nvim_buf_set_extmark = function(...)
	pcall(vim.api.nvim_buf_set_extmark, ...)
end

M.refresh = function()
	local c = M.config[vim.bo.filetype]
	local bufnr = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_clear_namespace(0, M.namespace, 0, -1)

	if not c or not c.query then
		return
	end

	local language = c.treesitter_language or vim.bo.filetype
	local language_tree = vim.treesitter.get_parser(bufnr, language)
	local syntax_tree = language_tree:parse()
	local root = syntax_tree[1]:root()
	local win_view = vim.fn.winsaveview()
	local left_offset = win_view.leftcol
	local width = vim.api.nvim_win_get_width(0)

	for _, match, metadata in c.query:iter_matches(root, bufnr) do
		for id, node in pairs(match) do
			node = node[#node]
			local buffer = vim.api.nvim_get_current_buf()
			local ts_utils = require('nvim-treesitter.ts_utils')

			local capture = c.query.captures[id]
			local row, col = node:range()

			if capture == "headline" then
				local text = vim.treesitter.get_node_text(node, bufnr):lower()

				local hl_group = ''
				hl_group = ""

				if text:match("todo") or
					text:match("%-%-") then
					hl_group = 'Todo'
				end
				if text:match("done") or
					text:match("none") or
					text:match("ok") then
					hl_group = 'Done'
				end
				if text:match("issue") or
					text:match("warn") or
					text:match("mid") then
					hl_group = 'Warn'
				end
				if text:match("err") or
					text:match("high") then
					hl_group = 'Erro'
				end
				if not (hl_group == '') then
					local virt_text = {}
					nvim_buf_set_extmark(bufnr, M.namespace, row, 0, {
						end_col = 0,
						end_row = row + 1,
						hl_group = hl_group,
						virt_text = virt_text,
						virt_text_pos = "overlay",
						hl_eol = true,
					})
				end
			end
		end
	end
end

return M

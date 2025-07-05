local cmp = require('cmp')
local cmp_lsp = require("cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
	"force",
	{},
	vim.lsp.protocol.make_client_capabilities(),
	cmp_lsp.default_capabilities())

require("fidget").setup({})

vim.lsp.config.lua_ls = {
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "it", "describe", "before_each", "after_each" },
			}
		}
	}
}

vim.lsp.config.harper_ls = {
	settings = {
		["harper-ls"] = {
			userDictPath = "",
			fileDictPath = "",
			linters = {
				SpellCheck = true,
				SpelledNumbers = false,
				AnA = false,
				SentenceCapitalization = true,
				UnclosedQuotes = true,
				WrongQuotes = false,
				LongSentences = true,
				RepeatedWords = false,
				Spaces = false,
				Matcher = false,
				CorrectNumberSuffix = false
			},
			codeActions = {
				ForceStable = false
			},
			markdown = {
				IgnoreLinkTitle = false
			},
			diagnosticSeverity = "hint",
			isolateEnglish = true,
			dialect = "American",
			maxFileLength = 120000
		}
	}
}

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		'lua_ls',
		'jedi_language_server',
		'clangd',
		--'tsserver',
		--'solc',
	},
	handlers = {
		function(server_name) -- default handler (optional)
			print(server_name)
			require("lspconfig")[server_name].setup {
				capabilities = capabilities
			}
		end,
	}
})

local cmp_bahavior = cmp.SelectBehavior.Insert;

cmp.setup({
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		-- Simple tab complete
		['<Tab>'] = cmp.mapping(function(fallback)
			local col = vim.fn.col('.') - 1

			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp_behavior })
			elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
				fallback()
			else
				print("help")
				cmp.complete()
			end
		end, { 'i', 's' }),

		-- Go to previous item
		['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp_behavior }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer' },
	})
})

vim.diagnostic.config({
	float = {
		focusable = true,
		style = "minimal",
		source = "always",
		header = "",
		prefix = "",
	},
})

local lsp = require("lsp-zero")

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	-- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	-- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	-- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	-- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	-- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	-- vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	-- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	-- vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	-- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

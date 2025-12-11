local vim = vim

require('mason').setup()

require('lint').linters_by_ft = {
	python = { 'ruff' },
}
vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
	callback = function()
		require('lint').try_lint()
	end,
})

require('zen-mode').setup({
	window = {
		width = 90,
		backdrop = 1,
	},
	on_open = function(win)
		-- To enable the zen mode gutters to be transparent, the following code
		-- has been added. This could use a refactor/simplification
		vim.wo[win].winhighlight = 'Normal:ZenBg,NormalNC:ZenBg'
		vim.api.nvim_set_hl(0, 'ZenBg', { bg = 'NONE' })
		vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
		vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
		vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
		vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
		vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
		vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
	end,
	on_close = function()
		vim.api.nvim_set_hl(0, 'ZenBg', {})
	end,
})

-- Toggle Zen Mode with <leader>z
vim.keymap.set(
	'n',
	'<leader>z',
	':ZenMode<CR>',
	{ silent = true, desc = 'Toggle Zen Mode' }
)

-- Close Neovim if ZenMode is the last window
vim.api.nvim_create_autocmd('User', {
	pattern = 'ZenLeave',
	callback = function()
		-- restore :q to default behavior when leaving Zen
		vim.keymap.del('n', 'q', { buffer = 0 })
	end,
})

vim.api.nvim_create_autocmd('User', {
	pattern = 'ZenEnter',
	callback = function()
		-- in ZenMode, redefine q to quit nvim if last buffer
		vim.keymap.set('n', 'q', function()
			if #vim.api.nvim_list_wins() == 1 then
				vim.cmd('qa') -- quit all of Neovim
			else
				vim.cmd('q') -- just quit Zen window
			end
		end, { buffer = 0 })
	end,
})

require('ibl').setup({
	indent = { char = '▏' },
	whitespace = { highlight = { 'Whitespace', 'NonText' } },
})

-- Colorizer config
require('colorizer').setup()

-- Autopair config
require('nvim-autopairs').setup({})

-- Telescope
local ts = require('telescope')
ts.setup({
	defaults = {
		ripgrep_arguments = {
			'rg',
			'--hidden',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case',
		},
	},
	extensions = {
		file_browser = {
			hijack_netrw = true,
			grouped = true,
			display_stat = { size = true, mode = true },
		},
	},
})
ts.load_extension('file_browser')

-- Config lualine
require('lualine').setup({
	options = {
		icons_enabled = true,
	},
})

-- Nightfox config
--local palettes = require('lsys_theme')
--require('nightfox').setup({ palettes = palettes })
--vim.cmd('colorscheme nightfox')

-- Autocomplete config
local cmp = require('cmp')
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn['vsnip#anonymous'](args.body)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
	}, {
		{ name = 'buffer' },
	}),
	-- TODO: disable snippets in comments
	--enabled = function()
	--    local context = require("cmp.config.context")
	--    if context.in_treesitter_capture("comment") or context.in_syntax_group("Comment") then
	--        return false
	--    else
	--        return true
	--    end
	--end
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' },
	}, {
		{ name = 'cmdline' },
	}),
})

-- LSP config
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Rust
vim.lsp.config('rust_analyzer', {
	capabilities = capabilities,
	settings = { ['rust-analyzer'] = { check = { command = 'clippy' } } },
})
vim.lsp.enable('rust_analyzer')

-- Lua
vim.lsp.config(
	'lua_ls',
	{ cmd = { 'lua-language-server' }, capabilities = capabilities }
)
vim.lsp.enable('lua_ls')

-- Bash / Zsh
vim.lsp.config('bashls', {
	capabilities = capabilities,
	filetypes = { 'bash', 'sh', 'zsh' },
})
vim.lsp.enable('bashls')

vim.lsp.enable('pyright')

-- Treesitter config
local tsconfig = require('nvim-treesitter.configs')
tsconfig.setup({
	ensure_installed = {
		'c',
		'go',
		'python',
		'rust',
		'lua',
		'vue',
		'javascript',
		'typescript',
		'tsx',
		'vue',
	},
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

-- Conform formatting config
local conform = require('conform')
conform.setup({
	formatters_by_ft = {
		lua = { 'stylua' },
		python = { 'ruff_format', 'ruff_fix' },
		javascript = { 'prettierd', 'prettier', stop_after_first = true },
		typescript = { 'prettierd', 'prettier', stop_after_first = true },
		javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
		typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
		vue = { 'prettierd', 'prettier', stop_after_first = true },
		svelte = { 'prettierd', 'prettier', stop_after_first = true },
		css = { 'prettierd', 'prettier', stop_after_first = true },
		scss = { 'prettierd', 'prettier', stop_after_first = true },
		html = { 'prettierd', 'prettier', stop_after_first = true },
		htmldjango = { 'prettierd', 'prettier', stop_after_first = true },
		json = { 'prettierd', 'prettier', stop_after_first = true },
		yaml = { 'prettierd', 'prettier', stop_after_first = true },
		markdown = { 'prettierd', 'prettier', stop_after_first = true },
		rust = { 'rustfmt' },
		tex = { 'latexindent' },
		go = { 'gofmt' },
		cmake = { 'cmake-format' },
		sh = { 'shfmt' },
		zsh = { 'shfmt' },
		dart = { 'dart_format' },
		zig = { 'zigfmt' },
	},
	formatters = {
		latexindent = {
			command = 'latexindent',
			args = { '-m', '-g', '/dev/null' }, -- enable line wrapping and overwrite
		},
	},
	--formatters = {
	--    prettier = {
	--      args = function(self, ctx)
	--        return { "--stdin-filepath", "$FILENAME",
	--            "--plugin", "/usr/local/lib/node_modules/prettier-plugin-tailwindcss/dist/index.mjs",
	--            "--plugin", "/usr/local/lib/node_modules/prettier-plugin-classnames/dist/index.js",
	--            "--plugin", "/usr/local/lib/node_modules/prettier-plugin-merge/dist/index.js",
	--            "--print-width", "80"}
	--      end,
	--    },
	--},
})

-- TODO this is not a plugin, its a custom theme
--vim.cmd('hi clear')
--require('colsync').apply_theme()
vim.api.nvim_create_autocmd('VimEnter', {
	callback = function()
		require('colsync').apply_theme()
	end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*',
	callback = function(args)
		conform.format({
			bufnr = args.buf,
			async = false,
			timeout_ms = 500,
			lsp_format = 'fallback ',
		})
	end,
})

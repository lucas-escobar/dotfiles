local vim = vim

require("lsp_lines").setup()

require("ibl").setup({
	indent = { char = "▏" },
	whitespace = { highlight = { "Whitespace", "NonText" } },
})

-- Colorizer config
require("colorizer").setup()

-- Autopair config
require("nvim-autopairs").setup({})

-- Telescope
local ts = require("telescope")
ts.setup({
	extensions = {
		file_browser = {
			hijack_netrw = true,
			grouped = true,
			display_stat = { size = true, mode = true },
		},
	},
})
ts.load_extension("file_browser")

-- Config lualine
require("lualine").setup({
	options = {
		icons_enabled = true,
	},
})

-- Nightfox config
local palettes = require("lsys_theme")
require("nightfox").setup({ palettes = palettes })
vim.cmd("colorscheme nightfox")

-- Autocomplete config
local cmp = require("cmp")
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
	}, {
		{ name = "buffer" },
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
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Cmp capabilities for lspconfig
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- LSP config
local lspconfig = require("lspconfig")
lspconfig.rust_analyzer.setup({ capabilities = capabilities })
lspconfig.pyright.setup({ capabilities = capabilities })
lspconfig.lua_ls.setup({ capabilities = capabilities })
lspconfig.volar.setup({ capabilities = capabilities })
--lspconfig.ts_ls.setup({
--	capabilities = capabilities,
--	init_options = {
--		plugins = {
--			{
--				name = "@vue/typescript-plugin",
--				location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
--				languages = { "javascript", "typescript", "vue" },
--			},
--		},
--	},
--	filetypes = {
--		"javascript",
--		"typescript",
--		"typescriptreact",
--		"javascriptreact",
--		"vue",
--	},
--})
lspconfig.eslint.setup({ capabilities = capabilities })
lspconfig.tailwindcss.setup({ capabilities = capabilities })
lspconfig.texlab.setup({ capabilities = capabilities })
lspconfig.gopls.setup({ capabilities = capabilities })
lspconfig.clangd.setup({ capabilities = capabilities })
lspconfig.cmake.setup({ capabilities = capabilities })
lspconfig.bashls.setup({ capabilities = capabilities })
lspconfig.dartls.setup({ capabilities = capabilities })
lspconfig.zls.setup({ capabilities = capabilities })
lspconfig.denols.setup({ capabilities = capabilities })

-- Treesitter config
local tsconfig = require("nvim-treesitter.configs")
tsconfig.setup({
	ensure_installed = { "c", "go", "python", "rust", "lua", "vue", "javascript", "typescript", "latex", "tsx", "vue" },
})

-- Conform formatting config
local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "autopep8" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		vue = { "prettierd", "prettier", stop_after_first = true },
		svelte = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", "prettier", stop_after_first = true },
		yaml = { "prettierd", "prettier", stop_after_first = true },
		markdown = { "prettierd", "prettier", stop_after_first = true },
		rust = { "rustfmt" },
		tex = { "latexindent" },
		go = { "gofmt" },
		cmake = { "cmake-format" },
		sh = { "shfmt" },
		dart = { "dart_format" },
		zig = { "zigfmt" },
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

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		conform.format({
			bufnr = args.buf,
			async = false,
			timeout_ms = 500,
			lsp_format = "fallback ",
		})
	end,
})

local vim = vim

-- Comment config
require("Comment").setup()

-- Colorizer config
require("colorizer").setup()

-- Autopair config
require("nvim-autopairs").setup({})

-- Oil config
require("oil").setup({
	default_file_explorer = false,
	columns = { "icon" },
	float = {
		-- Padding around the floating window
		padding = 2,
		max_width = 0,
		max_height = 0,
		border = "rounded",
		win_options = {
			winblend = 0,
		},
		-- This is the config that will be passed to nvim_open_win.
		-- Change values here to customize the layout
		override = function(conf)
			return conf
		end,
	},
})

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
require("lualine").setup()

-- Nightfox config
local palettes = {
	-- Change nordfox to match the nordic Alacritty theme
	nordfox = {
		black = {
			base = "#191C1D", -- Normal black
			bright = "#727C7C", -- Bright black
			dim = "#242933", -- Dim black (background color)
		},
		red = {
			base = "#BD6062", -- Normal red
			bright = "#D18FAF", -- Bright red
			dim = "#762121", -- Dim red (darker variant)
		},
		green = {
			base = "#A3D6A9", -- Normal green
			bright = "#B7CEB0", -- Bright green
			dim = "#5E8C61", -- Dim green (darker variant)
		},
		yellow = {
			base = "#F0DFAF", -- Normal yellow
			bright = "#FFF6BF", -- Bright yellow (lighter version of base)
			dim = "#A8975E", -- Dim yellow (darker variant)
		},
		blue = {
			base = "#8FB4D8", -- Normal blue
			bright = "#C5D8F5", -- Bright blue (lighter version of base)
			dim = "#5E81AC", -- Dim blue (darker variant)
		},
		magenta = {
			base = "#C7A9D9", -- Normal magenta
			bright = "#E2D2F1", -- Bright magenta (lighter version of base)
			dim = "#9168A6", -- Dim magenta (darker variant)
		},
		cyan = {
			base = "#87C0CD", -- Normal cyan
			bright = "#C3E6ED", -- Bright cyan (lighter version of base)
			dim = "#47818E", -- Dim cyan (darker variant)
		},
		white = {
			base = "#BDC5BD", -- Normal white
			bright = "#F6F6F6", -- Bright white (lighter version of base)
			dim = "#7C7C7C", -- Dim white (darker variant)
		},
		bg0 = "#1C1F21", -- Darker variant of base background color
		bg1 = "#242933", -- Base background color
		bg2 = "#2B303B", -- Incrementally lighter background color
		bg3 = "#353B45", -- Incrementally lighter background color
		bg4 = "#3E4451", -- Incrementally lighter background color

		fg0 = "#AAAAAA", -- Darker variant of base foreground color
		fg1 = "#BBBDAF", -- Base foreground color
		fg2 = "#CBCED0", -- Incrementally lighter foreground color
		fg3 = "#D7DADC", -- Incrementally lighter foreground color
		fg4 = "#E2E5E9", -- Incrementally lighter foreground color

		sel0 = "#353B45", -- Selection color (slightly lighter)
		sel1 = "#2B303B", -- Selection color (slightly lighter)
		comment = "#8A8FAD",
	},
}
require("nightfox").setup({ palettes = palettes })
vim.cmd("colorscheme nordfox")

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
lspconfig.volar.setup({
	capabilities = capabilities,
	-- volar handles other ts/js filetypes
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
})
lspconfig.texlab.setup({
	capabilities = capabilities,
	--filetypes = { "tex", "plaintex", "bib", "cls" },
})
lspconfig.gopls.setup({ capabilities = capabilities })

-- Treesitter config
local tsconfig = require("nvim-treesitter.configs")
tsconfig.setup({
	ensure_installed = { "go", "python", "rust", "lua", "vue", "javascript", "typescript", "latex" },
})

-- Conform formatting config
local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "autopep8" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		vue = { "prettier" },
		rust = { "rustfmt" },
		tex = { "latexindent" },
		go = { "gofmt" },
		markdown = { "prettier" },
	},
	format_on_save = {
		-- options to be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
})

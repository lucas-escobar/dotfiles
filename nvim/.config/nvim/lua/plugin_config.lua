local vim = vim

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
lspconfig.volar.setup({	capabilities = capabilities })
lspconfig.ts_ls.setup({ 
    capabilities = capabilities,
    init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
            languages = {"javascript", "typescript", "vue"},
          },
        },
      },
      filetypes = {
        "javascript",
        "typescript",
        "typescriptreact",
        "javascriptreact",
        "vue",
      },
})
lspconfig.eslint.setup({ capabilities = capabilities })
lspconfig.tailwindcss.setup({ capabilities = capabilities })
lspconfig.texlab.setup({ capabilities = capabilities })
lspconfig.gopls.setup({ capabilities = capabilities })
lspconfig.clangd.setup({ capabilities = capabilities })
lspconfig.cmake.setup({ capabilities = capabilities })
lspconfig.bashls.setup({ capabilities = capabilities })

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
		conform.format({ bufnr = args.buf, async = true, timeout_ms = 500, lsp_format = "fallback "})
	end,
})

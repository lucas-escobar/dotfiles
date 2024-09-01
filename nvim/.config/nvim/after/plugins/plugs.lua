local vim = vim
local Plug = vim.fn["plug#"]
vim.call("plug#begin")

-- Git integration
Plug("tpope/vim-fugitive")

-- Configure the native neovim lsp
Plug("neovim/nvim-lspconfig")

-- Improved syntax highlighting
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })

-- Fuzzy finding
Plug("nvim-telescope/telescope.nvim", { ["tag"] = "0.1.5" })
Plug("nvim-lua/plenary.nvim")
Plug("BurntSushi/ripgrep")
Plug("sharkdp/fd")
Plug("nvim-tree/nvim-web-devicons")
Plug("nvim-telescope/telescope-file-browser.nvim")

-- Highlighting color values (ie. #FFFFFF)
Plug("norcalli/nvim-colorizer.lua")

-- Commenting out code
Plug("numToStr/Comment.nvim")

-- Color theme management
Plug("EdenEast/nightfox.nvim")

-- Auto pairing brackets and quotes
Plug("windwp/nvim-autopairs")

-- Autocompletion
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/cmp-vsnip")
Plug("hrsh7th/vim-vsnip")
Plug("rafamadriz/friendly-snippets")

-- Buffer-style file tree editing
--Plug("stevearc/oil.nvim")

-- Code formatter
Plug("stevearc/conform.nvim")

-- Change the style of the nvim status bar
Plug("nvim-lualine/lualine.nvim")

vim.call("plug#end")

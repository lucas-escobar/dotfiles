return {
  -- UI
  { "folke/zen-mode.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "norcalli/nvim-colorizer.lua" },

  -- Git
  { "tpope/vim-fugitive" },

  -- LSP
  { "neovim/nvim-lspconfig" },

  -- Syntax Highlighting
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Fuzzy Finder
  { "nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-telescope/telescope-file-browser.nvim", dependencies = "nvim-telescope/telescope.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "BurntSushi/ripgrep" },
  { "sharkdp/fd" },

  -- Auto pairing
  { "windwp/nvim-autopairs" },

  -- Autocompletion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-vsnip" },
  { "hrsh7th/vim-vsnip" },
  { "rafamadriz/friendly-snippets" },

  -- Code formatter
  { "stevearc/conform.nvim" },

  -- Status bar
  { "nvim-lualine/lualine.nvim" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "ErichDonGubler/lsp_lines.nvim" },

  -- LSP installer & manager
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim", dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" } },
}

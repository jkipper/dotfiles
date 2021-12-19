return function(use)
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"neovim/nvim-lspconfig",
			"williamboman/nvim-lsp-installer",
			"rafamadriz/friendly-snippets",
			"jose-elias-alvarez/null-ls.nvim",
			"onsails/lspkind-nvim",
		},
		config = function() require("completion.conf")() end ,
	})
end

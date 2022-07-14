return function(use)
	use {
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"neovim/nvim-lspconfig",
			"williamboman/nvim-lsp-installer",
			"onsails/lspkind-nvim",
			"b0o/schemastore.nvim",
			"p00f/clangd_extensions.nvim",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lua",
			{"RRethy/vim-illuminate", config = function() vim.g.Illuminate_delay = 500 end},
      { "mtoohey31/cmp-fish", ft = "fish" }
		},
		config = function()
			require("completion.conf").cmp()
			require("completion.conf").lsp()
		end,
	}
	use {
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup { floating_window = false, hint_enable = true }
		end,
	}

	use {
		"saadparwaiz1/cmp_luasnip",
		requires = {
			{
				"L3MON4D3/LuaSnip",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
          require("completion.snippets").init()
				end,
			},
			{ "rafamadriz/friendly-snippets" },
		},
	}
	use {
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("completion.conf").diagnostic()
		end,
	}
end

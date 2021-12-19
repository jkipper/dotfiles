return function(use)
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = "andymass/vim-matchup",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"cpp",
					"c",
					"bash",
					"lua",
					"python",
					"cmake",
					"comment",
					"jsonc",
					"yaml",
					"dockerfile",
				},
				highlight = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "leadervb",
						node_incremental = "+",
						node_decremental = "-",
						scope_incremental = "<leader>+",
					},
				},
				matchup = {
					enable = true,
					disable_virtual_text = { "python" },
				},
			})
		end,
	})
	use({
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({})
		end,
	})
	use({
		"romgrk/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({})
		end,
	})
end

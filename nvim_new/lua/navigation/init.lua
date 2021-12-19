return function(use)
	use("ggandor/lightspeed.nvim")
	use("unblevable/quick-scope")
	use("tpope/vim-projectionist")
  require("navigation.dashboard")(use)
  require("navigation.file_tree")(use)
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	})
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})
end

return function(use)
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-tree").setup({ filter = { custom = { ".git", ".pyc$" } } })
		end,
	})
	use("ggandor/lightspeed.nvim")
	use("unblevable/quick-scope")
	use("tpope/vim-projectionist")
	use("glepnir/dashboard-nvim")
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

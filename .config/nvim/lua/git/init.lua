return function(use)
	use "tpope/vim-fugitive"
  use "rhysd/conflict-marker.vim"
	use {
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	}
	use {
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup {}
		end,
	}
end

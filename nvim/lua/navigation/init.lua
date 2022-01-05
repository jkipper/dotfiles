return function(use)
	use {
		"ggandor/lightspeed.nvim",
		config = function()
			require("lightspeed").setup { ignore_case = true }
		end,
	}
	use "unblevable/quick-scope"
	use "tpope/vim-projectionist"
	require "navigation.dashboard"(use)
	require "navigation.file_tree"(use)
	use {
		"zeertzjq/which-key.nvim",
    branch = "patch-1",
		config = function()
			require("which-key").setup {}
		end,
	}
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup {}
		end,
	}
	use {
		"chentau/marks.nvim",
		config = function()
			require("marks").setup {}
		end,
	}
end

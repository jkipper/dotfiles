return function(use)
	use "sickill/vim-pasta"
	use "tommcdo/vim-exchange"
	use { "glts/vim-radical", requires = { "glts/vim-magnum" } }
	use "tpope/vim-repeat"
	use "tpope/vim-surround"
  use "vim-scripts/ReplaceWithRegister"
	use {
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup {}
		end,
	}
	require "modifiers.doc_gen"(use)
	require "modifiers.formatter"(use)
end

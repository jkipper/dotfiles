return function(use)
	use {
		"plasticboy/vim-markdown",
		requires = "godlygeek/tabular",
		ft = "markdown",
	}
	use {
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown" },
	}
end

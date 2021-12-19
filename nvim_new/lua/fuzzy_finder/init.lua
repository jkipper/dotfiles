return function(use)
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},

		config = function()
			local trouble = require("trouble.providers.telescope")
			require("telescope").setup({
				defaults = {
					mappings = {
						i = { ["<a-x>"] = trouble.open_with_trouble },
						n = { ["<a-x>"] = trouble.open_with_trouble },
					},
				},
			})
		end,
	})
end

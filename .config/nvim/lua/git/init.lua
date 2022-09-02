local cmd = require"utils".cmd

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
		"TimUntersberger/neogit",
		requires = {
			"sindrets/diffview.nvim",
			config = function()
				require("diffview").setup {}
			end,
		},
		config = function()
			require("neogit").setup { disable_commit_confirmation = true, integrations = { diffview = true } }
			vim.keymap.set("n", "<leader>gg", cmd "Neogit", { noremap = true, silent = true })
		end,
	}
end

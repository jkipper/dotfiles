return function(use)
	use {
		"ggandor/leap.nvim",
		config = function()
			local leap = require "leap"
			leap.set_default_keymaps()
			leap.opts.special_keys.next_match = "<tab>"
			leap.opts.special_keys.prev_match = "<s-tab>"
		end,
	}
	use "tpope/vim-projectionist"
	require "navigation.dashboard"(use)
	require "navigation.file_tree"(use)
	use {
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup {}
		end,
	}
	use {
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup { auto_preview = false }
			vim.keymap.set("n", "<leader>go", "<cmd>SymbolsOutline<CR>", { noremap = true, silent = true })
		end,
	}
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup {}
			local keymap_opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", keymap_opts)
			vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", keymap_opts)
			vim.keymap.set("n", "<leader>xx", "<cmd>TroubleClose<cr>", keymap_opts)
		end,
	}
	use {
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup {}
		end,
	}
	use {
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup {}
		end,
	}
end

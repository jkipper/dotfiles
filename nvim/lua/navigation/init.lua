return function(use)
	use {
		"ggandor/lightspeed.nvim",
		config = function()
			require("lightspeed").setup { ignore_case = true }
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
  vim.g.symbols_outline = {auto_preview=false}
  use {
    "simrat39/symbols-outline.nvim"
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
		"chentau/marks.nvim",
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

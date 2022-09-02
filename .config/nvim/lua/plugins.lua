return require("packer").startup(function(use)
	use { "wbthomason/packer.nvim" }
	use {
		"folke/tokyonight.nvim",
		config = function()
			vim.cmd "colorscheme tokyonight"
		end,
	}
	use {
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup {}
		end,
	}
	use {
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require "notify"
		end,
	}
	require "building"(use)
	require "nv_treesitter"(use)
	require "git"(use)
	require "markdown"(use)
	require "statusline"(use)
	require "navigation"(use)
	require "fuzzy_finder"(use)
	require "completion"(use)
	require "testing"(use)
	require "modifiers"(use)
	require("utils.reload").setup()
	require "containers.containers"
	require("utils.replacer").setup()
end)

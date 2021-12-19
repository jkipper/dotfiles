return function(use)
	use("sickill/vim-pasta")
	use("tommcdo/vim-exchange")
	use({ "glts/vim-radical", requires = { "glts/vim-magnum" } })
	use("tpope/vim-repeat")
	use("sbdchd/neoformat")
	use("tpope/vim-surround")
	use({
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup{
        line_mapping = "<leader>cc",
        operator_mapping = "<leader>c"
      }
		end,
	})
	use({
		"kkoomen/vim-doge",
		run = function()
			vim.fn["doge#install"]()
		end,
	})
end

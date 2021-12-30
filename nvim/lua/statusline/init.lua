return function(use)
	use {
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup { options = { theme = "tokyonight" } }
		end,
	}

	use {
		"akinsho/bufferline.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("bufferline").setup {
				options = {
					numbers = "none",
					separator_style = "thin",
					close_icon = "",
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "center",
						},
					},
				},
			}
		end,
	}
end

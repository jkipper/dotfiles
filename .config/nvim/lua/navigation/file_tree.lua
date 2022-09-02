return function(use)
	use {
		"nvim-neo-tree/neo-tree.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup {
				filesystem = {
					filtered_items = {
						hide_dotfiles = false,
						hide_by_name = {
							".git",
							"*.pyc$",
						},
						never_show = {
							".DS_Store",
						},
					},
					follow_current_file = true,
					window = {
						mappings = {
							["F"] = "clear_filter",
						},
					},
				},
				window = {
					mappings = {
						["<C-V>"] = "open_vsplit",
						["<C-X>"] = "open_split",
					},
				},
			}

			local keymap_opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<C-e>", "<cmd>NeoTreeFocusToggle<cr>", keymap_opts)
			vim.keymap.set("n", "<C-b>", "<cmd>NeoTreeFocusToggle buffers<cr>", keymap_opts)
		end,
	}
	use {
		-- only needed if you want to use the commands with "_with_window_picker" suffix
		"s1n7ax/nvim-window-picker",
		tag = "v1.*",
		config = function()
			require("window-picker").setup {
				autoselect_one = true,
				include_current = false,
				filter_rules = {
					bo = {
						filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

						buftype = { "terminal" },
					},
				},
				other_win_hl_color = "#e35e4f",
			}
		end,
	}
end

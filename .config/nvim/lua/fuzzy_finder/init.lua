function file_picker()
  local opts = require("telescope.themes").get_ivy {}
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end



return function(use)
	use {
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},

		config = function()
			local trouble = require "trouble.providers.telescope"
			require("telescope").setup {
				defaults = {
					mappings = {
						i = {
							["<a-x>"] = trouble.open_with_trouble,
							["<C-h>"] = "which_key",
						},
						n = { ["<a-x>"] = trouble.open_with_trouble },
					},
				},
			}
			require("telescope").load_extension "fzf"
			require("telescope").load_extension "projects"

			local keymap_opts = { noremap = true, silent = true }
			local telescope = require "telescope.builtin"
			vim.keymap.set("n", "<C-P>", file_picker, keymap_opts)
			vim.keymap.set("n", "<C-F>", telescope.current_buffer_fuzzy_find, keymap_opts)
			vim.keymap.set("n", "<leader>sf", telescope.live_grep, keymap_opts)
			vim.keymap.set("n", "<leader>sb", telescope.buffers, keymap_opts)
			vim.keymap.set("n", "<leader>sr", telescope.registers, keymap_opts)
			vim.keymap.set("n", "<leader>sj", telescope.jumplist, keymap_opts)
			vim.keymap.set("n", "<leader>sd", telescope.diagnostics, keymap_opts)
			vim.keymap.set("n", "<leader>gs", telescope.git_status, keymap_opts)
			vim.keymap.set("n", "<leader>gc", telescope.git_commits, keymap_opts)
			vim.keymap.set("n", "<leader>gb", telescope.git_branches, keymap_opts)
		end,
	}
end

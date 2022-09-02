return function(use)
	use {
		"jkipper/neovim-cmake",
		branch = "Add-preset-support",
		config = function()
			require("cmake").setup {
				quickfix_only_on_error = true,
			}
		end,
	}

	use {
		"akinsho/toggleterm.nvim",
		tag = "v2.*",
		config = function()
			require("toggleterm").setup {
				size = function(term)
					return vim.o.columns * 0.6
				end,
				open_mapping = [[<C-T>]],
				direction = "vertical",
			}
		end,
	}

	use {
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap", "theHamsta/nvim-dap-virtual-text" },
    cmd = "DapUiToggle",
		config = function()
      require("dapui").setup {}
			require("nvim-dap-virtual-text").setup {}
			vim.api.nvim_create_user_command("DapUiToggle", require("dapui").toggle, {})
			vim.keymap.set("n", "<leader>tb", require("dap").toggle_breakpoint, { silent = true, noremap = true })
			vim.keymap.set("n", "<F10>", require("dap").step_over, { silent = true, noremap = true })
			vim.keymap.set("n", "<F11>", require("dap").step_into, { silent = true, noremap = true })
			vim.keymap.set("n", "<leader><F11>", require("dap").step_out, { silent = true, noremap = true })
			vim.keymap.set("n", "<leader><F5>", require("dap").continue, { silent = true, noremap = true })
		end,
	}
end

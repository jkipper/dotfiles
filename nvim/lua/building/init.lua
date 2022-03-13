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
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap", "theHamsta/nvim-dap-virtual-text" },
		config = function()
			require("dapui").setup {}
      require("nvim-dap-virtual-text").setup{}
			vim.keymap.set("n", "<leader>td", require("dapui").toggle, { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>tb", require("dap").toggle_breakpoint, { silent = true, noremap = true })
      vim.keymap.set("n", "<F10>", require("dap").step_over, { silent = true, noremap = true })
      vim.keymap.set("n", "<F11>", require("dap").step_into, { silent = true, noremap = true })
      vim.keymap.set("n", "<leader><F11>", require("dap").step_out, { silent = true, noremap = true })
      vim.keymap.set("n", "<leader><F5>", require("dap").continue, { silent = true, noremap = true })
		end,
	}
end

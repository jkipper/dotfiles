local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim" })
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "maintained",
				highlight = { enable = true },
				tree_docs = { enable = true },
			})
		end,
	})
	use("folke/tokyonight.nvim")
	use("voldikss/vim-floaterm")
	require("git")(use)
	require("markdown")(use)
	require("statusline")(use)
	require("navigation")(use)
	require("fuzzy_finder")(use)
	require("modifiers")(use)
  require("completion")(use)
	if packer_bootstrap then
		require("packer").sync()
	end
end)

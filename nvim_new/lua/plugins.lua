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
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-tree").setup({ filter = { custom = { ".git", ".pyc$" } } })
		end,
	})
	use("tpope/vim-fugitive")
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	})
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
	use("danilo-augusto/vim-afterglow")
	use({ "sonph/onehalf", rtp = "vim" })
	use("folke/tokyonight.nvim")
	use("rmehri01/onenord.nvim")
	use("joshdick/onedark.vim")
	use("voldikss/vim-floaterm")

	use("ggandor/lightspeed.nvim")
	use({
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup()
		end,
	})
	use({ "plasticboy/vim-markdown", requires = "godlygeek/tabular" })
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown" },
	})
	use({
		"famiu/feline.nvim",
		opt = false,
		config = function()
			require("feline").setup({})
		end,
	})

	use({
		"akinsho/bufferline.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
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
			})
		end,
	})
	use("tpope/vim-surround")
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"neovim/nvim-lspconfig",
			"williamboman/nvim-lsp-installer",
			"rafamadriz/friendly-snippets",
			"jose-elias-alvarez/null-ls.nvim",
			"onsails/lspkind-nvim",
		},
	})
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
		config = function()
			local trouble = require("trouble.providers.telescope")
			require("telescope").setup({
				defaults = {
					mappings = {
						i = { ["<a-x>"] = trouble.open_with_trouble },
						n = { ["<a-x>"] = trouble.open_with_trouble },
					},
				},
			})
		end,
	})
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})
	use("sickill/vim-pasta")
	use("tommcdo/vim-exchange")
	use("unblevable/quick-scope")
	use({ "glts/vim-radical", requires = { "glts/vim-magnum" } })
	use("tpope/vim-repeat")
	use("tpope/vim-projectionist")
	use("glepnir/dashboard-nvim")
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	})
	if packer_bootstrap then
		require("packer").sync()
	end
end)

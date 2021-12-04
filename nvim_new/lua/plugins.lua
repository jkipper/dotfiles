local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    })
end
vim.cmd [[packadd packer.nvim]]
return require("packer").startup(function(use)
    use {"wbthomason/packer-nvim"}
    use {
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require"nvim-tree".setup {filter = {custom = {".git", ".pyc$"}}}
        end
    }
    use "tpope/vim-fugitive"
    use {
        "lewis6991/gitsigns.nvim",
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require'gitsigns'.setup() end
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        disabled = not vim.fn.has("win32"),
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = "maintained",
                highlight = {enable = true},
                tree_docs = {enable = true}
            }
        end
    }
    use "joshdick/onedark.vim"
    use "voldikss/vim-floaterm"

    use {"junegunn/fzf", run = ":call fzf#install()"}
    use "junegunn/fzf.vim"

    use "justinmk/vim-sneak"
    use {
        "terrortylor/nvim-comment",
        config = function() require("nvim_comment").setup() end
    }
    use {"plasticboy/vim-markdown", requires = "godlygeek/tabular"}

    use {
        "famiu/feline.nvim",
        opt = false,
        config = function() require"feline".setup {} end
    }

    use {
        "akinsho/bufferline.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require"bufferline".setup {
                options = {
                    numbers = "none",
                    separator_style = "thin",
                    close_icon = "",
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "center"
                        }
                    }
                }
            }
        end
    }
    use {
        "mhartington/formatter.nvim",
        config = function()
            require"formatter".setup({
                filetype = {
                    python = {
                        function()
                            return {
                                exe = "black",
                                args = {"--line-length=120", "-"},
                                stdin = true
                            }
                        end
                    },
                    lua = {
                        function()
                            return {
                                exe = "lua-format",
                                args = {"--"},
                                stdin = true
                            }
                        end
                    }
                }
            })
        end
    }
    use "tpope/vim-surround"
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline", "hrsh7th/cmp-vsnip", "hrsh7th/vim-vsnip",
            "neovim/nvim-lspconfig", "williamboman/nvim-lsp-installer",
            "rafamadriz/friendly-snippets"
        }
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require'telescope'.setup() end
    }
    if packer_bootstrap then require('packer').sync() end
end)

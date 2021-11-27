return require("packer").startup(function(use)
    use "wbthomason/packer-nvim"
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
    use {"neovim/nvim-lspconfig", requires = "williamboman/nvim-lsp-installer"}
    use {
        "ms-jpq/coq_nvim",
        branch = "coq",
        requires = {"ms-jpq/coq.artifacts", branch = "artifacts"}
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require'telescope'.setup() end
    }
end)

return require("packer").startup(
    function(use)
        use "wbthomason/packer-nvim"
        use {"neoclide/coc.nvim", branch = "release"}
        use {
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require "nvim-tree".setup {
                    filter = {custom = {".git", ".pyc$"}}
                }
            end
        }
        use "tpope/vim-fugitive"
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
        use {"terrortylor/nvim-comment", config = function()
                require("nvim_comment").setup()
            end}
        use {"plasticboy/vim-markdown", requires = "godlygeek/tabular"}
        use {"famiu/feline.nvim", config = function()
                require "feline".setup()
            end}

        use {
            "akinsho/bufferline.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require "bufferline".setup {
                    options = {
                        numbers = "none",
                        separator_style = "thin",
                        close_icon = ""
                    }
                }
            end
        }
        use {"mhartington/formatter.nvim", config = function()
                require "formatter".setup()
            end}
    end
)


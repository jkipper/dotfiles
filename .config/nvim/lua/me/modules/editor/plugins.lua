local conf = require "me.modules.editor.config"
local export = require("me.core.pack").export_config(conf)
return export {
    telescope = {
        "nvim-telescope/telescope.nvim",
    },
    treesitter = {
        "nvim-treesitter/nvim-treesitter",
    },
    leap = {
        "ggandor/leap.nvim",
    },
    comment = {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup {}
        end,
    },
    surround = { "tpope/vim-surround" },
    dot_repeat = { "tpope/vim-repeat" },
    autopairs = {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end,
    },
    editorconfig = { "editorconfig/editorconfig-vim" },
    which_key = {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {}
        end,
    },
    project_manager = {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {}
        end,
    },
    markdown = { "plasticboy/vim-markdown" },
    neoclip = { "AckslD/nvim-neoclip.lua" },
    projectionist = {"tpope/vim-projectionist"}
}

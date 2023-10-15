local conf = require "me.modules.editor.config"
local export = require("me.core.pack").export_config(conf)
return export {
    telescope = {
        "nvim-telescope/telescope.nvim",
    },
    treesitter = {
        "nvim-treesitter/nvim-treesitter",
    },
    comment = {
        "numToStr/Comment.nvim",
        config = function() require("Comment").setup {} end,
    },
    surround = {
        "kylechui/nvim-surround",
        config = function() require("nvim-surround").setup {} end,
    },
    dot_repeat = { "tpope/vim-repeat" },
    autopairs = {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end,
    },
    editorconfig = { "editorconfig/editorconfig-vim" },
    which_key = {
        "folke/which-key.nvim",
        config = function() require("which-key").setup {} end,
    },
    quickscope = {
        "jinh0/eyeliner.nvim",
        config = function()
            require("eyeliner").setup {
                highlight_on_key = true,
                dim = false,
            }
        end,
    },
    markdown = { "plasticboy/vim-markdown" },
    neoclip = { "AckslD/nvim-neoclip.lua" },
    projectionist = { "tpope/vim-projectionist" },
}

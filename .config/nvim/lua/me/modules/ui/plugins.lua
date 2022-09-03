local c = require "me.modules.ui.config"
local export = require("me.core.pack").export_config(c)
return export {
    theme = {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd "colorscheme tokyonight"
        end,
    },
    neotree = {
        "nvim-neo-tree/neo-tree.nvim",
    },
    lualine = {
        "nvim-lualine/lualine.nvim",
    },

    bufferline = {
        "akinsho/bufferline.nvim",
    },
    dashboard = {
        "glepnir/dashboard-nvim",
    },
    outline = { "simrat39/symbols-outline.nvim" },
    trouble = { "folke/trouble.nvim" },
    notify = {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require "notify"
        end,
    },
    dressing = {
        "stevearc/dressing.nvim",
        config = function()
            require("dressing").setup {}
        end,
    },
    scriptease = { "tpope/vim-scriptease" },
    terminal = { "akinsho/toggleterm.nvim", tag = "V2.*" },
}

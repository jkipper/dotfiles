local c = require "me.modules.ui.config"
local export = require("me.core.pack").export_config(c)
return export {
    theme = {
        "folke/tokyonight.nvim",
        config = function() vim.cmd.colorscheme "tokyonight" end,
    },
    other_theme = {
        "rebelot/kanagawa.nvim",
        -- config = function() vim.cmd.colorscheme "kanagawa" end
    },
    lualine = { "nvim-lualine/lualine.nvim" },
    file_explorer = {
        "stevearc/oil.nvim",
        config = function() require("oil").setup() end,
    },
    trouble = { "folke/trouble.nvim", cmd = "Trouble" },
    dressing = {
        "stevearc/dressing.nvim",
        config = function() require("dressing").setup {} end,
    },
    scriptease = { "tpope/vim-scriptease", cmd = "Messages" },
}

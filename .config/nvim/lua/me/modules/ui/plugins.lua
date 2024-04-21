local c = require "me.modules.ui.config"
local export = require("me.core.pack").export_config(c)
return export {
    theme = {
        "folke/tokyonight.nvim",
        config = function() vim.cmd.colorscheme "tokyonight" end,
    },
    other_theme = {
        "rebelot/kanagawa.nvim",
    },
    lualine = { "nvim-lualine/lualine.nvim" },
    lsp_status = {
        "j-hui/fidget.nvim",
        tag = "legacy",
        config = function()
            require("fidget").setup { sources = { ["null-ls"] = { ignore = true } } }
        end,
    },
    file_explorer = {
        "stevearc/oil.nvim",
        config = function() require("oil").setup() end,
    },
    trouble = { "folke/trouble.nvim", cmd = "Trouble" },
    notify = {
        "rcarriga/nvim-notify",
        config = function() vim.notify = require "notify" end,
    },
    dressing = {
        "stevearc/dressing.nvim",
        config = function() require("dressing").setup {} end,
    },
    scriptease = { "tpope/vim-scriptease", cmd = "Messages" },
}

local c = require "me.modules.ui.config"
local export = require("me.core.pack").export_config(c)
return export {
    theme = {
        "folke/tokyonight.nvim",
        config = function() vim.cmd "colorscheme tokyonight" end,
    },
    neotree = {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = { "Neotree", "NeoTreeFocusToggle" },
    },
    lualine = { "nvim-lualine/lualine.nvim" },
    lsp_status = {
        "j-hui/fidget.nvim",
        config = function() require("fidget").setup { sources = { ["null-ls"] = { ignore = true } } } end,
    },

    bufferline = {
        "akinsho/bufferline.nvim",
    },
    dashboard = {
        "glepnir/dashboard-nvim",
    },
    outline = { "simrat39/symbols-outline.nvim", cmd = "SymbolsOutline" },
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
    terminal = { "akinsho/toggleterm.nvim", tag = "v2.*" },
    scrolling = {
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup {
                mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
            }
        end,
    },
    window_manager = {
        "anuvyklack/windows.nvim",
        requires = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim",
        },
        config = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            require("windows").setup()
        end,
    },
}

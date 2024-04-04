local c = require "me.modules.completion.config"
local export = require("me.core.pack").export_config(c)

return export {
    lspsaga = {
        "nvimdev/lspsaga.nvim",
        branch = "main",
        cmd = "Lspsaga",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        config = function() require("lspsaga").setup { finder_action_keys = { open = "<CR>" } } end,
    },
    nvimcmp = { "hrsh7th/nvim-cmp" },
    lsp = { "neovim/nvim-lspconfig" },
    lsp_signature = {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup { floating_window = false, hint_enable = true }
        end,
    },
    golang = {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function() require("go").setup() end,
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },
    lspinstall = { "williamboman/mason.nvim" },
    snip = { "L3MON4D3/LuaSnip" },
}

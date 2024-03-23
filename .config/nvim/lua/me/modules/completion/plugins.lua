local c = require "me.modules.completion.config"
local export = require("me.core.pack").export_config(c)

return export {
    lspsaga = {
        "glepnir/lspsaga.nvim",
        branch = "main",
        cmd = "Lspsaga",
        config = function() require("lspsaga").setup { finder_action_keys = { open = "<CR>" } } end,
    },
    nvimcmp = { "hrsh7th/nvim-cmp"},
    lsp = { "neovim/nvim-lspconfig" },
    lsp_signature = {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup { floating_window = false, hint_enable = true }
        end,
    },
    lspinstall = { "williamboman/mason.nvim" },
    snip = { "L3MON4D3/LuaSnip" },
}

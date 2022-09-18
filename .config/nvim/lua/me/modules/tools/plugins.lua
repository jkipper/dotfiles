local c = require "me.modules.tools.config"
local export = require("me.core.pack").export_config(c)
return export {
    conflict = { "rhysd/conflict-marker.vim" },
    gitsigns = {
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitsigns").setup()
        end,
    },
    neogit = {
        "TimUntersberger/neogit",
        requires = {
            "sindrets/diffview.nvim",
            config = function()
                require("diffview").setup {}
            end,
        },
        config = function()
            require("neogit").setup { disable_commit_confirmation = true, integrations = { diffview = true } }
        end,
    },
    formatter = {
        "sbdchd/neoformat",
        cmd = "Neoformat",
    },
    docs = { "danymat/neogen" },
}

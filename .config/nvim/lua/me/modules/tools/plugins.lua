local c = require "me.modules.tools.config"
local export = require("me.core.pack").export_config(c)
return export {
    conflict = { "rhysd/conflict-marker.vim" },
    gitsigns = {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require("gitsigns").setup() end,
    },
    git = { "tpope/vim-fugitive" },
    formatter = {
        "sbdchd/neoformat",
        cmd = "Neoformat",
    },
    docs = { "danymat/neogen" },
    zoxide = { "nanotee/zoxide.vim" },
}

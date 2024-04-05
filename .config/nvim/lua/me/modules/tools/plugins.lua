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
    session = {
        "folke/persistence.nvim",
        event = "BufReadPre", -- only start session saving when an actual file was opened
        config = {
            vim.api.nvim_create_user_command(
                "SessionLoad",
                function() require("persistence").load() end, {}
            ),
            vim.api.nvim_create_user_command(
                "SessionRestore",
                function() require("persistence").load { last = true } end, {}
            ),
        },
    },
}

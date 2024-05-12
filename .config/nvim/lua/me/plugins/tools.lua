return {
    "tpope/vim-fugitive",
    "nanotee/zoxide.vim",
    "sbdchd/neoformat",
    "tpope/vim-scriptease",
    {"stevearc/oil.nvim", opts = {}},

    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- only start session saving when an actual file was opened
        config = {
            vim.api.nvim_create_user_command(
                "SessionLoad",
                function() require("persistence").load() end,
                {}
            ),
            vim.api.nvim_create_user_command(
                "SessionRestore",
                function() require("persistence").load { last = true } end,
                {}
            ),
        },
    },
}

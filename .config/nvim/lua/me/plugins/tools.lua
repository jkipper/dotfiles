return {
    "tpope/vim-fugitive",
    "nanotee/zoxide.vim",
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                python = { "ruff_format", "black" },
                -- Use a sub-list to run only the first available formatter
                go = { "goimports", "gofmt" },
                toml = { "taplo" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
            },
        },
    },
    "tpope/vim-scriptease",
    { "stevearc/oil.nvim", opts = {} },

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

return {
    {
        "tadmccorkle/markdown.nvim",
        ft = "markdown",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "lukas-reineke/headlines.nvim",
        },
        init = function()
            vim.g.vim_markdown_folding_disabled = 1
            vim.g.vim_markdown_conceal = 0
            vim.g.vim_markdown_frontmatter = 1
            vim.g.vim_markdown_toml_frontmatter = 1
        end,
    },

    {
        "AckslD/nvim-neoclip.lua",
        dependencies = {
            { "kkharji/sqlite.lua", module = "sqlite" },
            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require("neoclip").setup {}
            require("telescope").load_extension "neoclip"
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
    },
    {
        "danymat/neogen",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            snippet_engine = "luasnip",
            languages = {
                python = {
                    template = {
                        annotation_convention = "reST",
                    },
                },
            },
        },
    },
    "tpope/vim-projectionist",
    "tpope/vim-repeat",
    { "kylechui/nvim-surround", opts = {} },
    { "windwp/nvim-autopairs", opts = {} },
    "christoomey/vim-tmux-navigator",
}

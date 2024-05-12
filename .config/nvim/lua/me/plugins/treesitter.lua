return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "andymass/vim-matchup",
        { "nvim-treesitter/nvim-treesitter-textobjects" },
        "nvim-treesitter/nvim-treesitter-context", -- TODO: use navic?
    },
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = {
                "cpp",
                "c",
                "lua",
                "python",
                "rst",
                "rust",
                "fish",
                "cmake",
                "comment",
                "go",
                "gotmpl",
                "gomod",
                "gosum",
                "bash",
                "jsonc",
                "yaml",
                "dockerfile",
                "query",
                "markdown",
                "markdown_inline",
                "gitcommit",
                "git_rebase",
                "vim",
            },
            ignore_install = {},
            modules = {},

            sync_install = false,
            auto_install = false,
            indent = {
                enable = true,
                disable = { "python" },
            },
            highlight = { enable = true },
            matchup = {
                enable = true,
                disable_virtual_text = { "python" },
            },
            query_linter = {
                enable = true,
                use_virtual_text = true,
                lint_events = { "BufWrite", "CursorHold" },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["il"] = "@loop.inner",
                        ["al"] = "@loop.outer",
                        ["ia"] = "@parameter.inner",
                        ["aa"] = "@parameter.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>s"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>S"] = "@parameter.inner",
                    },
                },
            },
        }
    end,
}

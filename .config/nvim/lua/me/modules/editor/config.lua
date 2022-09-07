---@type table<string, PluginConfig>
local M = {}

M.telescope = {
    requires = {
        {
            "nvim-lua/plenary.nvim",
        },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
        },
        { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    config = function()
        require("telescope").setup {
            defaults = {
                mappings = {
                    i = {
                        ["<C-H>"] = "which_key",
                    },
                },
                layout_config = {
                    prompt_position = "top",
                },
            },
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
                    theme = "ivy",
                },
                git_files = { theme = "ivy" },
                buffers = { theme = "ivy" },
            },
        }

        require("telescope").load_extension "fzf"
        require("telescope").load_extension "dotfiles"
        require("telescope").load_extension "projects"
        require("telescope").load_extension "neoclip"
        require("telescope").load_extension "live_grep_args"
    end,
}

M.treesitter = {
    requires = {
        "andymass/vim-matchup",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/playground",
        { "lewis6991/nvim-treesitter-context" },
    },
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = {
                "cpp",
                "c",
                "bash",
                "lua",
                "python",
                "fish",
                "cmake",
                "comment",
                "jsonc",
                "yaml",
                "dockerfile",
                "query",
                "markdown",
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
        require("treesitter-context").setup {}
    end,
}

M.leap = {
    requires = {},
    config = function()
        local leap = require "leap"
        leap.set_default_keymaps()
        leap.opts.special_keys.next_match = "<tab>"
        leap.opts.special_keys.prev_match = "<s-tab>"
    end,
}

vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_toml_frontmatter = 1
M.markdown = {
    requires = {
        { "godlygeek/tabular", ft = "markdown" },
        {
            "ellisonleao/glow.nvim",
            ft = "markdown",
        },
    },
}

M.neoclip = {
    requires = {
        { "kkharji/sqlite.lua", module = "sqlite" },
        { "nvim-telescope/telescope.nvim" },
    },
    config = function()
        require("neoclip").setup {}
    end,
}

return M

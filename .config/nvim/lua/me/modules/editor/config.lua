local M = {}

local telescope = {}
telescope.deps = {
    ["plenary.nvim"] = {
        "nvim-lua/plenary.nvim",
    },
    ["telescope-fzf-native.nvim"] = {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    },
}

telescope.conf = function()
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
        },
    }

    require("telescope").load_extension "fzf"
    require("telescope").load_extension "dotfiles"
end
M.telescope = telescope

local treesitter = {}

treesitter.deps = {
    ["vim-matchup"] = "andymass/vim-matchup",
    ["nvim-treesitter-textobjects"] = "nvim-treesitter/nvim-treesitter-textobjects",
    ["playground"] = "nvim-treesitter/playground",
    ["treesitter-context"] = { "lewis6991/nvim-treesitter-context" },
}

treesitter.conf = function()
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
end
M.treesitter = treesitter

M.leap = {
    deps = {},
    conf = function()
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
    deps = {
        tabular = { "godlygeek/tabular", ft = "markdown" },
        ["glow.nvim"] = {
            "ellisonleao/glow.nvim",
            ft = "markdown",
        },
    },
}

return M

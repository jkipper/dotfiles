---@type table<string, PluginConfig>
local M = {}

M.telescope = {
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
        },
        { "debugloop/telescope-undo.nvim" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    config = function()
        local actions = require "telescope.actions"
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
                buffers = {
                    theme = "ivy",
                    mappings = {
                        i = {
                            ["<c-w>"] = actions.delete_buffer + actions.move_to_top,
                        },
                    },
                },
            },
            extensions = {
                live_grep_args = {
                    auto_quoting = true, -- enable/disable auto-quoting
                    -- define mappings, e.g.
                    mappings = { -- extend mappings
                        i = {
                            ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                            ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt {
                                postfix = " --iglob ",
                            },
                        },
                    },
                },
            },
        }

        require("telescope").load_extension "fzf"
        require("telescope").load_extension "dotfiles"
        require("telescope").load_extension "neoclip"
        require("telescope").load_extension "live_grep_args"
        require("telescope").load_extension "undo"
    end,
}

M.treesitter = {
    dependencies = {
        "andymass/vim-matchup",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/playground",
        { "nvim-treesitter/nvim-treesitter-context" },
    },
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = {
                "cpp",
                "c",
                "lua",
                "python",
                "rust",
                "fish",
                "cmake",
                "comment",
                "jsonc",
                "yaml",
                "dockerfile",
                "query",
                "markdown",
            },
            indent = {
                enable = false,
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

vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_toml_frontmatter = 1
M.markdown = {
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "lukas-reineke/headlines.nvim",
    },
    config = true,
}

M.neoclip = {
    dependencies = {
        { "kkharji/sqlite.lua", module = "sqlite" },
        { "nvim-telescope/telescope.nvim" },
    },
    config = function() require("neoclip").setup {} end,
}

return M

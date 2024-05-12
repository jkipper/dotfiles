return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "debugloop/telescope-undo.nvim",
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
        }

        require("telescope").load_extension "fzf"
        require("telescope").load_extension "dotfiles"
        require("telescope").load_extension "undo"
    end,
}

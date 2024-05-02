local conf = require "me.modules.editor.config"
local export = require("me.core.pack").export_config(conf)
return export {
    telescope = {
        "nvim-telescope/telescope.nvim",
    },
    treesitter = {
        "nvim-treesitter/nvim-treesitter",
    },
    surround = {
        "kylechui/nvim-surround",
        config = function() require("nvim-surround").setup {} end,
    },
    dot_repeat = { "tpope/vim-repeat" },
    autopairs = {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end,
    },
    editorconfig = { "editorconfig/editorconfig-vim" },
    which_key = {
        "folke/which-key.nvim",
        config = function() require("which-key").setup {} end,
    },
    harpoon = {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require "harpoon"
            harpoon:setup()
            vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
            vim.keymap.set(
                "n",
                "<C-e>",
                function() harpoon.ui:toggle_quick_menu(harpoon:list()) end
            )

            vim.keymap.set("n", "<C-G>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<A-G>", function() harpoon:list():select(2) end)

            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
            vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
            vim.api.nvim_create_user_command(
                "HarpoonClear",
                function() harpoon:list():clear() end,
                {}
            )
        end,
    },
    tmux = { "christoomey/vim-tmux-navigator" },
    quickscope = {
        "jinh0/eyeliner.nvim",
        config = function()
            require("eyeliner").setup {
                highlight_on_key = true,
                dim = false,
            }
        end,
    },
    markdown = { "tadmccorkle/markdown.nvim", ft = "markdown" },
    neoclip = { "AckslD/nvim-neoclip.lua" },
    projectionist = { "tpope/vim-projectionist" },
}

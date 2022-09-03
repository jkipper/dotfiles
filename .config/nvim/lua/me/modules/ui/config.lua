local M = {}

local neotree = {}

neotree.deps = {
    ["plenary.nvim"] = { "nvim-lua/plenary.nvim", opt = true },
    ["nvim-web-devicons"] = { "kyazdani42/nvim-web-devicons" },
    ["nui.nvim"] = { "MunifTanjim/nui.nvim" },
}

neotree.conf = function()
    require("neo-tree").setup {
        filesystem = {
            filtered_items = {
                hide_dotfiles = false,
                hide_by_name = {
                    ".git",
                    "*.pyc$",
                },
                never_show = {
                    ".DS_Store",
                },
            },
            follow_current_file = true,
            window = {
                mappings = {
                    ["F"] = "clear_filter",
                },
            },
        },
        window = {
            mappings = {
                ["<C-V>"] = "open_vsplit",
                ["<C-X>"] = "open_split",
            },
        },
    }
end
M.neotree = neotree

local bufferline = {}

bufferline.deps = {
    ["nvim-web-devicons"] = "kyazdani42/nvim-web-devicons",
    ["scope.nvim"] = "tiagovla/scope.nvim",
}
bufferline.conf = function()
    require("bufferline").setup {
        options = {
            separator_style = "thick",
            numbers = "buffer_id",
            close_icon = "",
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "File Explorer",
                    text_align = "center",
                },
            },
        },
    }
    require("scope").setup()
end
M.bufferline = bufferline

local lualine = {}
M.lualine = {
    conf = function()
        require("lualine").setup {
            options = {
                theme = "tokyonight",
            },
            extensions = { "neo-tree", "fugitive", "toggleterm", "nvim-dap-ui" },
        }
    end,
}

M.dashboard = {
    conf = function()
        local db = require "dashboard"
        local home = os.getenv "HOME"
        db.default_executive = "telescope"
        db.custom_header = {
            " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
            " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
            " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
            " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
            " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
            " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
        }
        db.custom_center = {
            {
                icon = "  ",
                desc = "Recently latest session                  ",
                shortcut = "SPC s l",
                action = "SessionLoad",
            },
            {
                icon = "  ",
                desc = "Recently opened files                   ",
                action = "DashboardFindHistory",
                shortcut = "SPC f h",
            },
            {
                icon = "  ",
                desc = "Find  File                              ",
                action = "Telescope find_files find_command=rg,--hidden,--files",
                shortcut = "SPC f f",
            },
            {
                icon = "  ",
                desc = "File Browser                            ",
                action = "Telescope file_browser",
                shortcut = "SPC f b",
            },
            {
                icon = "  ",
                desc = "Find  word                              ",
                action = "Telescope live_grep",
                shortcut = "SPC f w",
            },
            {
                icon = "  ",
                desc = "Open Personal dotfiles                  ",
                action = "Telescope dotfiles path=" .. home .. "/.config",
                shortcut = "SPC f d",
            },
        }
    end,
}

M.outline = {
    conf = function()
        require("symbols-outline").setup { auto_preview = false }
    end,
}

local trouble = {}
trouble.deps = { ["nvim-web-devicons"] = "kyazdani42/nvim-web-devicons" }
trouble.config = function()
    require("trouble").setup {}
end
M.trouble = trouble

M.terminal = {
    conf = function()
        require("toggleterm").setup {
            size = function(_)
                return vim.o.columns * 0.6
            end,
            open_mapping = [[<C-T>]],
            direction = "vertical",
        }
    end,
}

return M

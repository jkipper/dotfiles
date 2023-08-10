local M = {}
M.neotree = {
    dependencies = {
        { "nvim-lua/plenary.nvim", opt = true },
        { "kyazdani42/nvim-web-devicons" },
        { "MunifTanjim/nui.nvim" },
        {
            "s1n7ax/nvim-window-picker",
            tag = "v1.5",
            config = function()
                require("window-picker").setup {
                    autoselect_one = true,
                    include_current = false,
                    filter_rules = {
                        bo = {
                            filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },
                            buftype = { "terminal" },
                        },
                    },
                    other_win_hl_color = "#e35e4f",
                }
            end,
        },
    },
    config = function()
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
                follow_current_file = { enabled = true },
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
    end,
}

M.bufferline = {
    dependencies = {
        { "kyazdani42/nvim-web-devicons" },
        { "tiagovla/scope.nvim" },
    },
    lazy = false,
    config = function()
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
    end,
}

M.lualine = {
    config = function() require "me.modules.ui.lualine" end,
    lazy = false,
}

M.dashboard = {
    config = function()
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
                action = "Telescope oldfiles",
                shortcut = "SPC f h",
            },
            {
                icon = "  ",
                desc = "Find  File                              ",
                action = "Telescope find_files",
                shortcut = "SPC f f",
            },
            {
                icon = "  ",
                desc = "File Browser                            ",
                action = "Neotree",
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
    config = function()
        require("symbols-outline").setup { auto_preview = false, autofold_depth = 1 }
    end,
}

M.trouble = {
    dependencies = { { "kyazdani42/nvim-web-devicons" } },
    config = function() require("trouble").setup {} end,
}

M.terminal = {
    config = function() vim.g.floaterm_wintype = "vsplit" end,
}

return M

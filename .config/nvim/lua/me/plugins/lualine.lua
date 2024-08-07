local lualine_setup = function()
    local lualine = require "lualine"

    local tokyo_config = require "tokyonight.config"
    local colors = require("tokyonight.colors").setup(tokyo_config)

    local conditions = {
        buffer_not_empty = function() return vim.fn.empty(vim.fn.expand "%:t") ~= 1 end,
        hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
        check_git_workspace = function()
            local filepath = vim.fn.expand "%:p:h"
            local gitdir = vim.fn.finddir(".git", filepath .. ";")
            return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
    }
    local function diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
            return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
            }
        end
    end
    -- Config
    local config = {
        options = {
            -- Disable sections and component separators
            component_separators = "",
            section_separators = "",
            theme = "catppuccin-mocha",
        },
        sections = {
            -- these are to remove the defaults
            lualine_a = {},
            lualine_b = {},
            lualine_y = {},
            lualine_z = {},
            -- These will be filled later
            lualine_c = {},
            lualine_x = {},
        },
        inactive_sections = {
            -- these are to remove the defaults
            lualine_a = {},
            lualine_b = {},
            lualine_y = {},
            lualine_z = {},
            lualine_c = {},
            lualine_x = {},
        },

        extensions = { "neo-tree", "fugitive", "toggleterm", "nvim-dap-ui" },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component) table.insert(config.sections.lualine_c, component) end

    -- Inserts a component in lualine_x ot right section
    local function ins_right(component) table.insert(config.sections.lualine_x, component) end

    ins_left {
        -- mode component
        function() return "" end,
        color = function()
            -- auto change color according to neovims mode
            local mode_color = {
                n = colors.green,
                i = colors.red,
                v = colors.blue,
                [""] = colors.blue,
                V = colors.blue,
                c = colors.magenta,
                no = colors.red,
                s = colors.orange,
                S = colors.orange,
                [""] = colors.orange,
                ic = colors.yellow,
                R = colors.violet,
                Rv = colors.violet,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ["r?"] = colors.cyan,
                ["!"] = colors.red,
                t = colors.red,
            }
            return { fg = mode_color[vim.fn.mode()] }
        end,
        padding = { left = 1, right = 1 },
    }

    ins_left {
        "filename",
        cond = conditions.buffer_not_empty,
        color = { fg = colors.cyan, gui = "bold" },
        path = 1,
    }

    ins_left { "location" }

    ins_left { "progress", color = { fg = colors.fg, gui = "bold" } }

    ins_left {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " " },
        diagnostics_color = {
            color_error = { fg = colors.red },
            color_warn = { fg = colors.yellow },
            color_info = { fg = colors.cyan },
        },
    }

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left {
        function() return "%=" end,
    }

    ins_right {
        function()
            local msg = "No Active Lsp"
            local buf_ft = vim.api.nvim_buf_get_option_value(0, "filetype")
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then
                return msg
            end
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                end
            end
            return msg
        end,
        icon = ":",
        color = { fg = "#ffffff", gui = "bold" },
    }

    ins_right {
        "fileformat",
        fmt = string.upper,
        icons_enabled = true,
    }
    ins_right {
        "filetype",
        icon_only = true,
    }

    ins_right {
        "b:gitsigns_head",
        icon = "",
        color = { fg = colors.violet, gui = "bold" },
    }

    ins_right {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        source = diff_source,
        diff_color = {
            added = { fg = colors.green },
            modified = { fg = colors.orange },
            removed = { fg = colors.red },
        },
        cond = conditions.hide_in_width,
    }
    lualine.setup(config)
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "folke/tokyonight.nvim" },
    config = lualine_setup,
}

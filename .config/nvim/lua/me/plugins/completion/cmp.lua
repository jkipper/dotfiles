local lazydev = {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
        library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}

local blink = {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
        "L3MON4D3/LuaSnip",
        "folke/lazydev.nvim",
    },
    version = "v0.*",
    opts = {
        keymap = { preset = "enter" },
        snippets = {
            expand = function(snippet) require("luasnip").lsp_expand(snippet) end,
            active = function(filter)
                if filter and filter.direction then
                    return require("luasnip").jumpable(filter.direction)
                end
                return require("luasnip").in_snippet()
            end,
            jump = function(direction) require("luasnip").jump(direction) end,
        },
        sources = {
            default = { "lsp", "path", "luasnip", "buffer", "lazydev" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    fallbacks = { "lsp" },
                },
            },
        },
        completion = {
            list = {
                selection = {
                    preselect = function(ctx)
                        return ctx.mode == "cmdline" and "auto_insert" or "preselect"
                    end,
                },
            },
            documentation = { auto_show = true },
        },
        signature = { enabled = true },
    },
}

local luasnip = {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    config = function()
        local ls = require "luasnip"
        ls.config.set_config {
            store_selection_keys = "<C-S>",
            update_events = "TextChanged,TextChangedI",
        }

        local code_snippet_dir = "~/.config/nvim/snippets"
        if vim.fn.isdirectory(code_snippet_dir) then
            require("luasnip.loaders.from_vscode").lazy_load { paths = code_snippet_dir }
        end
        require("luasnip.loaders.from_vscode").lazy_load()

        local snippets = {
            python = vim.tbl_values(require "me.plugins.completion.snippets.python"),
            markdown = vim.tbl_values(require "me.plugins.completion.snippets.markdown"),
            lua = vim.tbl_values(require "me.plugins.completion.snippets.lua_snips"),
        }

        for file_type, snip in pairs(snippets) do
            ls.add_snippets(file_type, snip)
        end
        require "me.plugins.completion.snippets.go_err"
    end,
}

return { luasnip, blink, lazydev }

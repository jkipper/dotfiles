local nvim_cmp = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "onsails/lspkind-nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "paopaol/cmp-doxygen",
        "mtoohey31/cmp-fish",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "danymat/neogen",
    },
    config = function()
        local cmp = require "cmp"
        local snip = require "luasnip"
        local neogen = require "neogen"
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0
                and vim.api
                        .nvim_buf_get_lines(0, line - 1, line, true)[1]
                        :sub(col, col)
                        :match "%s"
                    == nil
        end
        cmp.setup {
            snippet = {
                expand = function(args) snip.lsp_expand(args.body) end,
            },
            formatting = {
                format = require("lspkind").cmp_format { mode = "symbol", maxwidth = 50 },
            },
            mapping = {
                ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<UP>"] = cmp.mapping.abort(),
                ["<DOWN>"] = cmp.mapping.abort(),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif snip and snip.expand_or_jumpable() then
                        snip.expand_or_jump()
                    elseif neogen and neogen.jumpable() then
                        neogen.jump_next()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-TAB>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif snip and snip.jumpable(-1) then
                        snip.jump(-1)
                    elseif neogen and neogen.jumpable(true) then
                        neogen.jump_prev()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<CR>"] = cmp.mapping.confirm(),
                ["<C-c>"] = cmp.mapping.abort(),
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "doxygen" },
                { name = "nvim_lua" },
                { name = "fish" },
            }, {
                { name = "buffer" },
                { name = "path" },
            }),
        }
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "nvim_lsp_document_symbol" },
            }, {
                { name = "buffer" },
            }),
        })
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources {
                { name = "cmdline" },
            },
        })
    end,
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

return { luasnip, nvim_cmp }

local lsp_plugin = {
    "neovim/nvim-lspconfig",
    dependencies = {
        "folke/neodev.nvim",
        "RRethy/vim-illuminate",
        "nvimtools/none-ls.nvim",
        "b0o/schemastore.nvim",
        "nvim-lua/lsp-status.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        { "mrcjkb/rustaceanvim", ft = { "rust" } },
    },
    config = function()
        local on_attach = function(client)
            require("illuminate").on_attach(client)
            vim.api.nvim_create_user_command(
                "InlayHintsToggle",
                function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = nil })
                end,
                {}
            )
        end
        local lsp_status = require "lsp-status"
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("neodev").setup {
            override = function(_, library)
                library.enabled = true
                library.plugins = true
            end,
        }
        local lsp = require "lspconfig"
        local default_conf = { on_attach = on_attach, capabilities = capabilities }

        lsp_status.register_progress()

        vim.g.rustaceanvim = { server = { on_attach = on_attach } }
        lsp.jsonls.setup {
            settings = { json = { schemas = require("schemastore").json.schemas() } },
            on_attach = on_attach,
            capabilities = capabilities,
        }
        lsp.yamlls.setup {
            settings = {
                yaml = {
                    schemaStore = {
                        enable = false,
                        url = "",
                    },
                    schemas = require("schemastore").json.schemas(),
                },
            },
        }

        lsp.basedpyright.setup {
            capabilities = capabilities,
            settings = {
                basedpyright = {
                    typeCheckingMode = "standard",
                },
            },
        }

        lsp.gopls.setup {
            capabilities = capabilities,
            settings = {
                gopls = {
                    hints = {
                        parameterNames = true,
                        constantValues = true,
                        rangeVariabletypes = true,
                    },
                    usePlaceholders = true,
                },
            },
        }

        for _, value in ipairs {
            "lua_ls",
            "dockerls",
            "vimls",
            "cmake",
            "bashls",
            "ocamllsp",
            "marksman",
            "taplo",
            "ruff_lsp",
            "cucumber_language_server",
            "yamlls",
        } do
            lsp[value].setup(default_conf)
        end

        local null_ls = require "null-ls"
        null_ls.setup {
            sources = {
                null_ls.builtins.code_actions.gitsigns,
                null_ls.builtins.diagnostics.fish,
                null_ls.builtins.diagnostics.hadolint,
                null_ls.builtins.diagnostics.mypy,
                null_ls.builtins.diagnostics.golangci_lint,
            },
            autostart = true,
        }
    end,
}
local cmp = require "me.plugins.completion.cmp"
return { lsp_plugin, cmp }

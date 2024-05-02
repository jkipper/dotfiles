local M = {}
M.dependencies = {
    { "folke/neodev.nvim" },
    { "RRethy/vim-illuminate" },
    { "nvimtools/none-ls.nvim" },
    { "b0o/schemastore.nvim" },
    { "nvim-lua/lsp-status.nvim" },
    { "mrcjkb/rustaceanvim", ft = { "rust" } },
}

M.config = function()
    local on_attach = function(client, bufnr)
        require("illuminate").on_attach(client)
        if client.server_capabilities.inlayHintProvider then
            vim.api.nvim_create_user_command(
                "InlayHintsToggle",
                function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
                {}
            )
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            vim.lsp.inlay_hint.enable()
        end
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

    for _, value in ipairs {
        "lua_ls",
        "pyright",
        "dockerls",
        "vimls",
        "cmake",
        "bashls",
        "marksman",
        "taplo",
        "gopls",
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
        },
        autostart = true,
    }
end

return M

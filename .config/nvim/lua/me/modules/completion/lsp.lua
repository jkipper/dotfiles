local M = {}
M.dependencies = {
    { "folke/neodev.nvim" },
    { "p00f/clangd_extensions.nvim" },
    { "RRethy/vim-illuminate" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "b0o/schemastore.nvim" },
    { "nvim-lua/lsp-status.nvim" },
    { "SmiteshP/nvim-navic" },
    { "mrcjkb/rustaceanvim", ft = { "rust" } },
    {
        "akinsho/flutter-tools.nvim",
        dependencies = "nvim-lua/plenary.nvim",
    },
}

M.config = function()
    local on_attach = function(client, bufnr)
        require("illuminate").on_attach(client)
        require("nvim-navic").attach(client, bufnr)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(bufnr, true)
        end
    end
    local lsp_status = require "lsp-status"
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    require("neodev").setup {}
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

    require("flutter-tools").setup { capabilities = capabilities }
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
        "yamlls",
    } do
        lsp[value].setup(default_conf)
    end

    local null_ls = require "null-ls"
    null_ls.setup {
        sources = {
            null_ls.builtins.code_actions.gitsigns,
            null_ls.builtins.diagnostics.gitlint,
            null_ls.builtins.diagnostics.fish,
            null_ls.builtins.diagnostics.hadolint,
            null_ls.builtins.diagnostics.shellcheck,
            null_ls.builtins.diagnostics.mypy,
        },
        autostart = true,
    }
end

return M

local M = {}
M.dependencies = {
    { "folke/neodev.nvim" },
    { "p00f/clangd_extensions.nvim" },
    { "RRethy/vim-illuminate" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "b0o/schemastore.nvim" },
    { "nvim-lua/lsp-status.nvim" },
    { "SmiteshP/nvim-navic" },
    { "simrat39/rust-tools.nvim" },
    {
        "akinsho/flutter-tools.nvim",
        dependencies = "nvim-lua/plenary.nvim",
    },
}

M.config = function()
    local on_attach = function(client, bufnr)
        require("illuminate").on_attach(client)
        require("nvim-navic").attach(client, bufnr)
    end
    local lsp_status = require "lsp-status"
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    require("neodev").setup {}
    local lsp = require "lspconfig"
    local default_conf = { on_attach = on_attach, capabilities = capabilities }

    lsp_status.register_progress()

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
    require("rust-tools").setup {
        server = {
            settings = {
                ["rust-analyzer"] = { checkOnSave = { command = "clippy" } },
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
        },
        autostart = true,
    }
end

return M

local M = {}
M.requires = {
    { "folke/neodev.nvim" },
    { "p00f/clangd_extensions.nvim" },
    { "RRethy/vim-illuminate" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "b0o/schemastore.nvim" },
    { "nvim-lua/lsp-status.nvim" },
    { "SmiteshP/nvim-navic" },
    { "simrat39/rust-tools.nvim" },
}

M.config = function()
    local on_attach = function(client, bufnr)
        require("illuminate").on_attach(client)
        require("nvim-navic").attach(client, bufnr)
    end
    local lsp_status = require "lsp-status"
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lsp = require "lspconfig"
    local default_conf = { on_attach = on_attach, capabilities = capabilities }

    lsp_status.register_progress()
    require("clangd_extensions").setup {
        server = {
            handlers = lsp_status.extensions.clangd.setup(),
            on_attach = on_attach,
            capabilities = vim.tbl_extend("force", capabilities, { offsetEncoding = { "utf-16" } }),
        },
    }
    require("neodev").setup {}

    lsp.jsonls.setup {
        settings = { json = { schemas = require("schemastore").json.schemas() } },
        on_attach = on_attach,
        capabilities = capabilities,
    }
    require("rust-tools").setup {}

    for _, value in ipairs {
        "sumneko_lua",
        "pyright",
        "dockerls",
        "vimls",
        "cmake",
        "bashls",
        "marksman",
        "taplo",
        "gopls",
    } do
        lsp[value].setup(default_conf)
    end

    local null_ls = require "null-ls"
    null_ls.setup {
        sources = {
            null_ls.builtins.code_actions.gitsigns,
            null_ls.builtins.diagnostics.flake8,
            null_ls.builtins.diagnostics.gitlint,
            null_ls.builtins.diagnostics.fish,
            null_ls.builtins.diagnostics.hadolint,
            null_ls.builtins.diagnostics.shellcheck,
        },
        autostart = true,
    }
end

return M

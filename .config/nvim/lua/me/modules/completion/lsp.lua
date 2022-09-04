-- schematstorecompl
-- parent = nvim-lspconfig
--
--

local on_attach = function(client, bufnr)
    require("illuminate").on_attach(client)
end
local M = {}
M.requires = {
    { "folke/lua-dev.nvim" },
    { "p00f/clangd_extensions.nvim" },
    { "RRethy/vim-illuminate" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "b0o/schemastore.nvim" },
}

M.config = function()
    local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local lsp = require "lspconfig"
    local default_conf = { on_attach = on_attach, capabilities = capabilities }

    require("clangd_extensions").setup {
        server = {
            on_attach,
            capabilities = vim.tbl_extend("force", capabilities, { offsetEncoding = { "utf-16" } }),
        },
    }

    lsp.sumneko_lua.setup(require("lua-dev").setup {
        library = {
            plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
        },
        lsponfig = default_conf,
    })

    lsp.jsonls.setup {
        settings = { json = { schemas = require("schemastore").json.schemas() } },
        on_attach = on_attach,
        capabilities = capabilities,
    }

    for _, value in ipairs { "pyright", "dockerls", "vimls", "cmake", "bashls", "marksman", "taplo" } do
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

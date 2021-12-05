local lsp = require "lspconfig"
local installer = require "nvim-lsp-installer"
local servers = {"jedi_language_server", "sumneko_lua", "dockerls", "jsonls", "clangd"}
local cmp = require 'cmp'

local try_require = function(module)
    local status, lfs = pcall(require, module)
    if status then return lfs end
end

local init_cmp = function()
    cmp.setup({
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end
        },
        mapping = {
            ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            ["<CR>"] = cmp.mapping.confirm({select = true}),
            ["<ESC>"] = cmp.mapping.abort()
        },
        sources = cmp.config.sources({{name = 'nvim_lsp'}, {name = 'vsnip'}},
                                     {name = 'buffer'}),
        experimental = {native_menu = false, ghost_test = true}
    })
end

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local opts = {noremap = true, silent = true}

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>Trouble lsp_references<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
                   opts)
    buf_set_keymap('n', '<leader>ff', '<cmd>lua vim.lsp.buf.formatting()<CR>',
                   opts)

end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())

init_cmp()

for _, server in ipairs(servers) do
    local server_available, requested_server = installer.get_server(server)
    if server_available then
        requested_server:on_ready(function()
            requested_server:setup({
                settings = try_require(server),
                on_attach = on_attach,
                capabilities = capabilities
            })
        end)
        if not requested_server:is_installed() then
            requested_server:install()
        end
    end
end

local null_on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ff',
                                '<cmd>lua vim.lsp.buf.formatting()<CR>',
                                {noremap = true, silent = true})
end

local null_ls = require('null-ls')
local formatters = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
null_ls.config({
    sources = {
        formatters.black.with({args = {'--line-length=120'}}),
        formatters.lua_format, formatters.clang_format
        --       diagnostics.flake8.with{args = {'--max-line-length','120'}}
    }
})

require("lspconfig")["null-ls"].setup({
    on_attach = null_on_attach,
    autostart = true
})


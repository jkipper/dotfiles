local lsp = require "lspconfig"
local coq = require "coq"
local installer = require "nvim-lsp-installer"

local servers = {"diagnosticls", "jedi_language_server", "sumneko_lua"}

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    local opts = {noremap = true, silent = true}

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
                   opts)
end
-- lsp.jedi_language_server.setup(coq.lsp_ensure_capabilities())

-- lsp.jedi_language_server.setup(coq.lsp_ensure_capabilities())
-- lsp.jsonls.setup(coq.lsp_ensure_capabilities())
for _, server in ipairs(servers) do
    local server_available, requested_server = installer.get_server(server)
    if server_available then
        requested_server:on_ready(function()
            local opts = {on_attach = on_attach}
            requested_server:setup(coq.lsp_ensure_capabilities(opts))
        end)
        if not requested_server:is_installed() then
            requested_server:install()
        end
    end
end

local lsp = require("lspconfig")
local installer = require("nvim-lsp-installer")
local cmp = require("cmp")
local lspkind = require("lspkind")
local servers = {
	"jedi_language_server",
	"sumneko_lua",
	"clangd",
	"dockerls",
	"jsonls",
}

local try_require = function(module)
	local status, lfs = pcall(require, module)
	if status then
		return lfs
	end
end


local configure_cmp = function()
	cmp.setup({
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body)
			end,
		},
		formatting = {
			format = lspkind.cmp_format({ with_text = true, maxwidth = 50 }),
		},
		mapping = {
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

			["<Tab>"] = cmp.mapping.select_next_item(),
			["<S-Tab>"] = cmp.mapping.select_prev_item(),
			["<CR>"] = cmp.mapping.confirm(),
			["<C-c>"] = cmp.mapping.abort(),
		},
		sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "vsnip" } }, { name = "buffer" }),
	})
end

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local opts = { noremap = true, silent = true }

	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>Trouble lsp_references<CR>", opts)
	buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local config_lsp_servers = function()
	for _, server in ipairs(servers) do
		local server_available, requested_server = installer.get_server(server)
		if server_available then
			requested_server:on_ready(function()
				requested_server:setup({
					settings = try_require("completion.lsp_settings/" .. server),
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end)
		end
	end
end

local config_diagnostic_lsp = function()
	local null_ls = require("null-ls")
	null_ls.setup({
		sources = {
			null_ls.builtins.diagnostics.flake8,
			null_ls.builtins.code_actions.gitsigns,
		},
		autostart = true,
	})
end

return function()
	configure_cmp()
	config_lsp_servers()
	config_diagnostic_lsp()
end

local lsp = require "lspconfig"
local installer = require "nvim-lsp-installer"
local lspkind = require "lspkind"
local servers = {
	"pyright",
	"sumneko_lua",
	"clangd",
	"dockerls",
	"jsonls",
}

local completion_config = {}

local try_require = function(module)
	local status, lfs = pcall(require, module)
	if status then
		return lfs
	end
end

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

completion_config.cmp = function()
	local cmp = require "cmp"
	local neogen = try_require "neogen"
	cmp.setup {
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body)
			end,
		},
		formatting = {
			format = lspkind.cmp_format { with_text = true, maxwidth = 50 },
		},
		mapping = {
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			["<UP>"] = cmp.config.disable,
			["<DOWN>"] = cmp.config.disable,
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif vim.fn["vsnip#available"](1) == 1 then
					feedkey("<Plug>(vsnip-expand-or-jump)", "")
				elseif neogen and neogen.jumpable() then
					neogen.jump_next()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function()
				if cmp.visible() then
					cmp.select_prev_item()
				elseif vim.fn["vsnip#jumpable"](-1) == 1 then
					feedkey("<Plug>(vsnip-jump-prev)", "")
				elseif neogen and neogen.jumpable(true) then
					neogen.jump_prev()
				end
			end, { "i", "s" }),
			["<CR>"] = cmp.mapping.confirm(),
			["<C-c>"] = cmp.mapping.abort(),
		},
		sources = cmp.config.sources(
			{ { name = "nvim_lsp" }, { name = "vsnip" }, { name = "nvim_lua" } },
			{ { name = "buffer" }, { name = "path" } }
		),
		sorting = {
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.recently_used,
				require "clangd_extensions.cmp_scores",
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
	}
	cmp.setup.cmdline("/", {
		sources = {
			{ name = "buffer" },
		},
	})
end

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = true }

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "H", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<CR>", opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

completion_config.lsp = function()
	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
	for _, server in ipairs(servers) do
		local server_available, requested_server = installer.get_server(server)
		if server_available then
			requested_server:on_ready(function()
				if requested_server.name == "clangd" then
					local opts = { on_attach = on_attach, capabilities = capabilities }
					require("clangd_extensions").setup {
						server = vim.tbl_deep_extend("force", requested_server:get_default_options(), opts),
					}
					requested_server:attach_buffers()
				else
					requested_server:setup {
						settings = try_require("completion.lsp_settings/" .. server),
						on_attach = on_attach,
						capabilities = capabilities,
					}
				end
			end)
			if not requested_server:is_installed() then
				print("Installing " .. server)
				requested_server:install()
			end
		end
	end
end

completion_config.diagnostic = function()
	local null_ls = require "null-ls"
	null_ls.setup {
		sources = {
			null_ls.builtins.diagnostics.flake8,
			null_ls.builtins.code_actions.gitsigns,
		},
		autostart = true,
	}
end

return completion_config

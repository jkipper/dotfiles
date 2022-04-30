local lsp = require "lspconfig"
local installer = require "nvim-lsp-installer"
local lspkind = require "lspkind"
local servers = {
  "pylsp",
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

completion_config.cmp = function()
  local cmp = require "cmp"
  local neogen = try_require "neogen"
  local snip = require "luasnip"
  cmp.setup {
    snippet = {
      expand = function(args)
        snip.lsp_expand(args.body)
      end,
    },
    formatting = {
      format = lspkind.cmp_format { with_text = true, maxwidth = 50 },
    },
    mapping = {
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<UP>"] = cmp.mapping.abort(),
      ["<DOWN>"] = cmp.mapping.abort(),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif snip and snip.expand_or_jumpable() then
          snip.expand_or_jump()
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
        elseif snip and snip.jumpable(-1) then
          snip.jump(-1)
        elseif neogen and neogen.jumpable(true) then
          neogen.jump_prev()
        end
      end, { "i", "s" }),
      ["<CR>"] = cmp.mapping.confirm(),
      ["<C-c>"] = cmp.mapping.abort(),
    },
    sources = cmp.config.sources(
      { { name = "nvim_lsp" }, { name = "luasnip" }, { name = "nvim_lua" } },
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
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    buffer = bufnr,
    callback = function()
      local diagnostic_opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
      }
      vim.diagnostic.open_float(nil, diagnostic_opts)
    end,
  })

  require"illuminate".on_attach(client)

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "H", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>H", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<CR>", opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  if client.resolved_capabilities.document_formatting then
    vim.keymap.set("n", "<leader>ff", vim.lsp.buf.formatting_sync, opts)
  end
  if client.name == "clangd" then
    vim.keymap.set("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>", opts)
  end
end

completion_config.lsp = function()
  require("nvim-lsp-installer").setup {
    ensure_installed = servers,
    automatic_installation = false,
    ui = {
      icons = {
        server_installed = "✓",
        server_pending = "➜",
        server_uninstalled = "✗",
      },
    },
  }
  local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
  for _, server in ipairs(servers) do
    if server == "clangd" then
      require("clangd_extensions").setup {
        server = {
          settings = try_require("completions.lsp_settings." .. server),
          on_attach = on_attach,
          capabilities = capabilities,
        },
      }
    else
      require("lspconfig")[server].setup {
        settings = try_require("completion.lsp_settings." .. server),
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end
  end
end

completion_config.diagnostic = function()
  local null_ls = require "null-ls"
  null_ls.setup {
    sources = {
      null_ls.builtins.code_actions.gitsigns,
    },
    autostart = true,
  }
end

return completion_config

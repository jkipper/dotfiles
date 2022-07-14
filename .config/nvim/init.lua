local g = vim.g
local opt = vim.opt

g.mapleader = " "
vim.cmd [[set guifont=JetBrainsMono\ Nerd\ Font\ Mono]]
local keymap_opts = { noremap = true, silent = true }
if g["vscode"] ~= nil then
  vim.keymap.set("n", "gc", [[<Plug>VSCodeCommentary]], keymap_opts)
  vim.keymap.set("n", "gcc", [[<Plug>VSCodeCommentaryLine]], keymap_opts)
else
  require "plugins"

  -- Markdown
  g.vim_markdown_folding_disabled = 1
  g.vim_markdown_conceal = 0
  g.vim_markdown_frontmatter = 1
  g.vim_markdown_toml_frontmatter = 1

  vim.keymap.set("n", "<leader>ff", "<cmd>Neoformat<CR>", keymap_opts)

  vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<CR>", keymap_opts)
  vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<CR>", keymap_opts)
  vim.keymap.set("n", "<leader>ts", "<cmd>TestSuite<CR>", keymap_opts)
  vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<CR>", keymap_opts)
  vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<CR>", keymap_opts)
end

vim.keymap.set("n", "<C-J>", "<C-W><C-J>", keymap_opts)
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", keymap_opts)
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", keymap_opts)
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", keymap_opts)

vim.keymap.set("v", "K", [[:m '<-2<cr>gv=gv]], keymap_opts)
vim.keymap.set("v", "J", [[:m '>+1<cr>gv=gv]], keymap_opts)

vim.keymap.set("n", "K", "<cmd>m--<cr>==", keymap_opts)
vim.keymap.set("n", "J", "<cmd>m+<cr>==", keymap_opts)

vim.keymap.set("n", "n", "nzzzv", keymap_opts)
vim.keymap.set("n", "N", "Nzzzv", keymap_opts)

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', keymap_opts)
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', keymap_opts)
vim.keymap.set({ "n", "v" }, "<leader>cy", '"*y', keymap_opts)
vim.keymap.set({ "n", "v" }, "<leader>cp", '"*p', keymap_opts)

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', keymap_opts)

vim.keymap.set("t", "<C-T>", "<C-\\><C-n>", keymap_opts)

opt.mouse = "nv"
opt.tabstop = 2
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.autoindent = true
opt.breakindent = true
opt.termguicolors = true
opt.backspace = { "indent", "eol", "start" }
opt.undofile = true
-- doesn't work with opt for some reason
vim.cmd "set noshowmode"
opt.completeopt = "menu,menuone,noselect"
opt.incsearch = true
opt.ruler = true
opt.wildmenu = true
opt.scrolloff = 5
opt.sidescrolloff = 10
opt.display:append { "lastline" }
opt.laststatus = 3
opt.formatoptions:append { "j" }
opt.autoread = true
opt.relativenumber = true
opt.number = true
opt.ignorecase = true
opt.smartcase = true
vim.wo.signcolumn = "yes"

opt.wildignore:append { "*.pyc", "*_build/*", "**coverage/*", "**/node_modules/*", "**/.git/" }

local highlight_group = vim.api.nvim_create_augroup("highlight_yank", {})
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = highlight_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})
local filetype_mappings = vim.api.nvim_create_augroup("filetype_mapping", {})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = filetype_mappings,
  pattern = { "Jenkinsfile*" },
  command = "set filetype=groovy",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = filetype_mappings,
  pattern = { "*.json" },
  command = "set filetype=jsonc",
})


vim.diagnostic.config {
  virtual_text = false,
}
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.o.updatetime = 100

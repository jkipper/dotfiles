local keymap = require "me.core.keymap"
local nmap = keymap.nmap
local vmap = keymap.vmap
local nvmap = keymap.nvmap
local cmd = keymap.cmd

local opt = vim.opt

vim.g.mapleader = " "

opt.mouse = "a"
opt.tabstop = 4

opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 4
opt.softtabstop = 4
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
opt.scrolloff = 10
opt.sidescrolloff = 10
opt.display:append { "lastline" }
opt.laststatus = 3 -- global statusline
opt.formatoptions:append { "j" }
opt.autoread = true
opt.relativenumber = true
opt.number = true
opt.smartcase = true
vim.wo.signcolumn = "yes"
opt.wildignore:append { "*.pyc", "*_build/*", "**coverage/*", "**/node_modules/*", "**/.git/" }
opt.cmdheight = 1
opt.errorbells = false

vim.g.guifont = "JetBrainsMono Nerd Font,JetBrainsMono Nerd Font Mono"
vim.g.neovide_input_macos_alt_is_meta = true

vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { noremap = true, silent = true })
-- window movement
nmap("<C-H>", cmd "<C-U>TmuxNavigateLeft")
nmap("<C-J>", cmd "<C-U>TmuxNavigateDown")
nmap("<C-K>", cmd "<C-U>TmuxNavigateUp")
nmap("<C-L>", cmd "<C-U>TmuxNavigateRight")

-- move lines up and down
vmap("<a-k>", [[:m '<-2<cr>gv=gv]])
vmap("<a-j>", [[:m '>+1<cr>gv=gv]])
nmap("<a-k>", [[:m--<cr>==]])
nmap("<a-j>", [[:m+<cr>==]])

-- center on search
nmap("n", [[nzzzv]])
nmap("N", [[Nzzzv]])

-- quick access to some registers
nvmap("<leader>y", '"+y')
nvmap("<leader>p", '"+p')
nvmap("<leader>cy", '"*y')
nvmap("<leader>cp", '"*p')
nvmap("<leader>d", '"_d')

vim.keymap.set("t", "<C-T>", "<C-\\><C-n>", { noremap = true, silent = true })

-- vim.diagnostic.config {
--     virtual_text = false,
-- }
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- for type, icon in pairs(signs) do
--     local hl = "DiagnosticSign" .. type
--     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

vim.o.updatetime = 100

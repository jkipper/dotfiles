local keymap = require "me.core.keymap"
local nmap = keymap.nmap
local imap = keymap.imap
local vmap = keymap.vmap
local nvmap = keymap.nvmap
local cmd = keymap.cmd

local function file_picker()
    local ok = pcall(require("telescope.builtin").git_files)
    if not ok then
        require("telescope.builtin").find_files()
    end
end

local telescope = require "telescope.builtin"
nmap("<C-P>", file_picker)
nmap("<C-F>", telescope.current_buffer_fuzzy_find)
-- nmap("<leader><C-P>", function()
-- 	require("fuzzy_finder.pickers").dotfiles(require("telescope.themes").get_ivy {})
-- end)
nmap("<leader>sf", telescope.live_grep)
nmap("<leader>sb", telescope.buffers)
nmap("<leader>sr", telescope.registers)
nmap("<leader>sj", telescope.jumplist)
nmap("<leader>sd", telescope.diagnostics)
nmap("<leader>gs", telescope.git_status)
nmap("<leader>gc", telescope.git_commits)
nmap("<leader>gb", telescope.git_branches)

nmap("<C-e>", cmd "NeoTreeFocusToggle")
nmap("<C-b>", cmd "NeoTreeFocusToggle buffers")

nmap("<A-,>", function()
    require("bufferline").cycle(-1)
end)
nmap("<A,.>", function()
    require("bufferline").cycle(1)
end)

nmap("<leader>go", cmd "SymbolsOutline")

nmap("<leader>xq", cmd "TroubleToggle quickfix")
nmap("<leader>xl", cmd "TroubleToggle loclist")
nmap("<leader>xx", cmd "TroubleClose")

nmap("<leader>gg", cmd "Neogit")

nmap("<leader>ff", cmd "Neoformat")
nmap("<leader>md", cmd "Neogen")

nmap("<leader>gd", cmd "Lspsaga preview_definition")
nmap("gr", cmd "Lspsaga lsp_finder")
nmap("K", cmd "Lspsaga hover_doc")
nmap("<leader>K", cmd "Lspsaga show_line_diagnostics")
nmap("<leader>rn", cmd "Lspsaga rename")
nmap("<leader>ca", cmd "Lspsaga code_action")
vmap("<leader>command", cmd "<C-U>Lspsaga range_code_action")

nmap("gD", vim.lsp.buf.declaration)
nmap("gd", vim.lsp.buf.definition)
nmap("gt", vim.lsp.buf.type_definition)
nmap("gi", vim.lsp.buf.implementation)

nmap("<leader>tb", function()
    require("dap").toggle_breakpoint()
end)
nmap("<F10>", function()
    require("dap").step_over()
end)

nmap("<F11>", function()
    require("dap").step_info()
end)
nmap("<leader><F11>", function()
    require("dap").step_out()
end)
nmap("<F5>", function()
    require("dap").continue()
end)

-- keep for later
if vim.g["vscode"] ~= nil then
    nmap("gc", [[<Plug>VSCodeCommentary]])
    nmap("gcc", [[<Plug>VSCodeCommentaryLine]])
end

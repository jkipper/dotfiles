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
nmap("<leader><C-F>", function() telescope.current_buffer_fuzzy_find() end)
nmap("<leader>sf", function() require("telescope").extensions.live_grep_args.live_grep_args() end)
nmap("<leader>sld", function() telescope.lsp_document_symbols() end)
nmap("<leader>slw", function() telescope.lsp_workspace_symbols() end)
nmap("<leader>sb", function() telescope.buffers() end)
nmap("<leader>sr", function() telescope.registers() end)
nmap("<leader>sj", function() telescope.jumplist() end)
nmap("<leader>sd", function() telescope.diagnostics() end)
nmap("<leader>gs", function() telescope.git_status() end)
nmap("<leader>gc", function() telescope.git_commits() end)
nmap("<leader>gb", function() telescope.git_branches() end)
nmap("<leader><C-P>", function() telescope.buffers() end)

nmap("<C-e>", cmd "NeoTreeFocusToggle")

nmap("<A-,>", function() require("bufferline").cycle(-1) end)
nmap("<A-.>", function() require("bufferline").cycle(1) end)

nmap("<C-T>", cmd "OverseerToggle")

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
nmap("<leader>ga", cmd "A")
nmap("gD", vim.lsp.buf.declaration)
nmap("gd", vim.lsp.buf.definition)
nmap("gt", vim.lsp.buf.type_definition)
nmap("gi", vim.lsp.buf.implementation)

nmap("<leader>tb", function() require("dap").toggle_breakpoint() end)
nmap("<F10>", function() require("dap").step_over() end)
nmap("<F11>", function() require("dap").step_info() end)
nmap("<leader><F11>", function() require("dap").step_out() end)
nmap("<F5>", function() require("dap").continue() end)

-- keep for later
if vim.g["vscode"] ~= nil then
    nmap("gc", [[<Plug>VSCodeCommentary]])
    nmap("gcc", [[<Plug>VSCodeCommentaryLine]])
end

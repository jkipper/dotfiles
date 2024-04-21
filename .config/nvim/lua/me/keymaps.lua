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

-- keep for later
if vim.g["vscode"] ~= nil then
    local vscode = require "vscode-neovim"
    nmap("gc", [[<Plug>VSCodeCommentary]])
    nmap("gcc", [[<Plug>VSCodeCommentaryLine]])
    nmap("<leader>ff", function() vscode.action "editor.action.formatSelection" end)
    nmap("gr", function() vscode.action "editor.action.goToReferences" end)
    nmap("<C-H>", function() vscode.action "workbench.action.navigateLeft" end)
    nmap("<C-J>", function() vscode.action "workbench.action.navigateDown" end)
    nmap("<C-K>", function() vscode.action "workbench.action.navigateUp" end)
    nmap("<C-L>", function() vscode.action "workbench.action.navigateRight" end)
else
    local telescope = require "telescope.builtin"
    nmap("<C-P>", file_picker)
    nmap("<leader><C-F>", function() telescope.current_buffer_fuzzy_find() end)
    nmap(
        "<leader>sf",
        function() require("telescope").extensions.live_grep_args.live_grep_args() end
    )
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
    nmap("<C-S-P>", function() telescope.commands() end)
    nmap("<leader>u", cmd "Telescope undo")

    nmap("<A-,>", function() require("bufferline").cycle(-1) end)
    nmap("<A-.>", function() require("bufferline").cycle(1) end)

    nmap("<leader>xq", cmd "Trouble quickfix")
    nmap("<leader>xl", cmd "Trouble loclist")
    nmap("<leader>xx", cmd "TroubleClose")

    nmap("<leader>gg", cmd "tab Git")

    nmap("<leader>ff", cmd "Neoformat")
    nmap("<leader>md", cmd "Neogen")

    nmap("<leader>gd", cmd "Lspsaga peek_definition")
    nmap("gr", cmd "Lspsaga finder")
    nmap("K", cmd "Lspsaga hover_doc")
    nmap("<leader>rn", cmd "Lspsaga rename")
    nmap("<leader>ca", cmd "Lspsaga code_action")
    nmap("<leader>H", cmd "Lspsaga show_line_diagnostics")
    nmap("<C-`>", cmd "Lspsaga term_toggle")
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
end

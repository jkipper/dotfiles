local keymap = require "me.core.keymap"
local nmap = keymap.nmap
local cmd = keymap.cmd

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
    nmap("<C-P>", function() telescope.find_files() end)
    nmap("<leader><C-F>", function() telescope.current_buffer_fuzzy_find() end)
    nmap("<leader>fs", function() telescope.live_grep() end)
    nmap("<leader>fld", function() telescope.lsp_document_symbols() end)
    nmap("<leader>flw", function() telescope.lsp_workspace_symbols() end)
    nmap("<leader>fb", function() telescope.buffers() end)
    nmap("<leader>fr", function() telescope.registers() end)
    nmap("<leader>fj", function() telescope.jumplist() end)
    nmap("<leader>fd", function() telescope.diagnostics() end)
    nmap("<leader>gs", function() telescope.git_status() end)
    nmap("<leader>gc", function() telescope.git_commits() end)
    nmap("<leader>gb", function() telescope.git_branches() end)
    nmap("<leader><C-P>", function() telescope.buffers() end)
    nmap("<C-S-P>", function() telescope.commands() end)
    nmap("<leader>u", cmd "Telescope undo")

    nmap("<leader>xq", cmd "Trouble quickfix")
    nmap("<leader>xl", cmd "Trouble loclist")
    nmap("<leader>xx", cmd "TroubleClose")

    nmap("<leader>gg", cmd "tab Git")
    nmap("gh", cmd "diffget //2")
    nmap("gl", cmd "diffget //3")

    nmap("<leader>ff", cmd "Neoformat")
    nmap("<leader>md", cmd "Neogen")

    nmap("<leader>gd", cmd "Lspsaga peek_definition")
    nmap("gr", cmd "Lspsaga finder")
    nmap("K", cmd "Lspsaga hover_doc")
    nmap("<leader>rn", cmd "Lspsaga rename")
    nmap("<leader>ca", cmd "Lspsaga code_action")
    nmap("<leader>K", cmd "Lspsaga show_line_diagnostics")
    nmap("<leader>ga", cmd "A")
    nmap("gD", vim.lsp.buf.declaration)
    nmap("gd", cmd "Lspsaga goto_definition")
    nmap("gt", cmd "Lspsaga goto_type_definition")
    nmap("gi", vim.lsp.buf.implementation)
    vim.keymap.set({ "i", "s" }, "<C-E>", function()
        local ls = require "luasnip"
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end, { silent = true })

    nmap("<leader>tb", function() require("dap").toggle_breakpoint() end)
    nmap("<F10>", function() require("dap").step_over() end)
    nmap("<F11>", function() require("dap").step_info() end)
    nmap("<leader><F11>", function() require("dap").step_out() end)
    nmap("<F5>", function() require("dap").continue() end)

    -- testing

    nmap("<leader>tr", function() require("neotest").run.run() end)
    nmap("<leader>ts", function() require("neotest").summary.toggle() end)
    nmap("<leader>tk", function() require("neotest").run.stop() end)

    nmap("<C-T>", function()
        require("plenary.job")
            :new({
                command = "tmux",
                args = { "resize-pane", "-Z" },
                on_exit = function()
                    vim.schedule(
                        function()
                            vim.cmd(
                                vim.api.nvim_replace_termcodes([[normal! <C-w>=]], true, true, true)
                            )
                        end
                    )
                end,
            })
            :start()
    end)

    -- misc
end

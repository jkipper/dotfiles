require "me.mini_tools.containers.containers"
require("me.mini_tools.cyclist").setup()

vim.api.nvim_create_user_command("Colormode", function(tbl)
    local theme = vim.g.colors_name
    local target = tbl.args
    if theme == "tokyonight" then
        if target == "dark" then
            vim.cmd.colorscheme "tokyonight-storm"
        elseif target == "light" then
            vim.cmd.colorscheme "tokyonight-day"
        end
    end
    if theme == "kanagawa" then
        if target == "dark" then
            vim.cmd.colorscheme "kanagawa-wave"
        elseif target == "light" then
            vim.cmd.colorscheme "kanagawa-lotus"
        end
    end
end, {
    nargs = 1,
    complete = function(_, _, _) return { "dark", "light" } end,
})

local ts_utils = require "nvim-treesitter.ts_utils"

local toggle_fstring = function()
    local winnr = 0
    local cursor = vim.api.nvim_win_get_cursor(winnr)
    local node = ts_utils.get_node_at_cursor()

    while (node ~= nil) and (node:type() ~= "string") do
        node = node:parent()
    end
    if node == nil then
        print "f-string: not in string node :("
        return
    end

    local srow, scol, ecol, erow = ts_utils.get_vim_range { node:range() }
    vim.fn.setcursorcharpos(srow, scol)
    local char = vim.api.nvim_get_current_line():sub(scol, scol)
    local is_fstring = (char == "f")

    if is_fstring then
        vim.cmd "normal x"
        -- if cursor is in the same line as text change
        if srow == cursor[1] then
            cursor[2] = cursor[2] - 1 -- negative offset to cursor
        end
    else
        vim.cmd "normal if"
        -- if cursor is in the same line as text change
        if srow == cursor[1] then
            cursor[2] = cursor[2] + 1 -- positive offset to cursor
        end
    end
    vim.api.nvim_win_set_cursor(winnr, cursor)
end

vim.keymap.set("n", "F", toggle_fstring, { noremap = true })

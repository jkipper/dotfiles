local ts_utils = require "nvim-treesitter.ts_utils"
local nmap = require("me.core.keymap").nmap

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

-- local group = vim.api.nvim_create_augroup("PythonFString", { clear = true })
-- vim.api.nvim_create_autocmd({ "InsertCharPre" }, {
--     pattern = { "*.lua", "*.py" },
--     desc = "Auto make f string",
--     group = group,
--     callback = function()
--         local max_characters = 100
--         local inserted_char = vim.v.char
--         if inserted_char == "{" or inserted_char == "}" then
--             local node = vim.treesitter.get_node()
--             if node == nil then
--                 return
--             end
--             while (node ~= nil) and (node:type() ~= "string") do
--                 node = node:parent()
--             end
--             if node == nil then
--                 print "f-string: not in string node :("
--                 return
--             end
--             local content = vim.treesitter.get_node_text(node, 0)
--
--             print("Node Type = ", vim.inspect(node:type()))
--             if content == "" or #content > max_characters then
--                 return
--             end
--             if content:find "^r?f" then
--                 print "already f string"
--                 return
--             else
--                 vim.defer_fn(function()
--                     local start_row, start_col, end_row, end_col = node:range()
--                     pcall(vim.cmd.undojoin) -- makes undos igmore the next change
--                     local updated_text =
--                         vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})
--                     print(vim.inspect(updated_text))
--                     local lines = vim.split("f" .. table.concat(updated_text, ""), "\n")
--                     vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, lines)
--                     local winnr = 0
--                     vim.cmd "norm! l"
--                 end, 5)
--             end
--         end
--     end,
-- })

nmap("<leader>mf", toggle_fstring)

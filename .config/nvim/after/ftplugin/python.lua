local ts_utils = require "nvim-treesitter.ts_utils"
local nmap = require("me.core.keymap").nmap

---@param start string
---@return TSNode | nil
local function get_starting_node(start)
    local node = vim.treesitter.get_node()
    if node == nil then
        return
    end
    while node:type() ~= start do
        local parent = node:parent()
        if parent == nil then
            return
        end
        node = parent
    end
    return node
end

local toggle_fstring = function()
    local winnr = 0
    local cursor = vim.api.nvim_win_get_cursor(winnr)
    local node = ts_utils.get_node_at_cursor()

    while (node ~= nil) and (node:type() ~= "string") do
        node = node:parent()
    end
    if node == nil then
        return
    end

    local srow, scol, _, _ = ts_utils.get_vim_range { node:range() }
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

local function f_to_log_string()
    local query = vim.treesitter.query.get("python", "log-f-string")
    if query == nil then
        vim.notify "Failed to load query"
    end

    local node = get_starting_node "call"
    if node == nil then
        return
    end

    ---@diagnostic disable-next-line: need-check-nil
    for id, capture, metadata in query:iter_captures(node, 0) do
        ---@diagnostic disable-next-line: need-check-nil
        if query.captures[id] ~= "cont" then
            goto continue
        end

        local current_text = vim.treesitter.get_node_text(capture, 0, metadata[id])

        local pattern = "{.-}"
        local match = current_text:match(pattern)
        while match do
            local var_name = match:sub(2, -2)
            current_text = current_text:gsub(pattern, "%%s", 1) .. ", " .. var_name
            match = current_text:match(pattern)
        end

        local start_row, start_col, end_row, end_col = capture:range()
        vim.api.nvim_buf_set_text(
            0,
            start_row,
            start_col,
            end_row,
            end_col,
            { current_text:sub(2) }
        )
        ::continue::
    end
end

nmap("<leader>mf", toggle_fstring)
nmap("<leader>ml", f_to_log_string)

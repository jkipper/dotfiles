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

local function parse()
    local query = vim.treesitter.query.get("python", "log-f-string")
    if query == nil then
        vim.notify "Failed to load query"
    end

    local node = get_starting_node "call"
    if node == nil then
        return
    end

    for id, capture, metadata in query:iter_captures(node, 0) do
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

return parse

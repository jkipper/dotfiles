local ls = require "luasnip"

local snippet = ls.snippet

local query = vim.treesitter.parse_query(
    "cpp",
    [[
(class_specifier
  name: (type_identifier) @name 
  (base_class_clause (type_identifier) @impl))
]]
)

local test = function()
    local cur_buffer = vim.api.nvim_get_current_buf()
    local parser = vim.treesitter.get_parser(0, "cpp", {})

    local tree = parser:parse()[1]

    for id, node, metadata in query:iter_captures(tree:root(), cur_buffer) do
        print(query.captures[id])
        print(metadata[id])
        local row1, col1, row2, col2 = node:range()
        local text =
            vim.api.nvim_buf_get_text(vim.api.nvim_get_current_buf(), row1, col1, row2, col2, {})
        print(text[1])
    end
end

vim.api.nvim_create_user_command("TSQuery", test, {})

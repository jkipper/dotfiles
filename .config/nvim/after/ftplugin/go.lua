local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function() require("go.format").goimports() end,
    group = format_sync_grp,
})

local ts_go_query = [[
(method_declaration result: (_) @type)
 (function_declaration result: (_) @type)
 (func_literal result: (_) @type)
]]

vim.treesitter.query.set("go", "Luasnip_Result", ts_go_query)

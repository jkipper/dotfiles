local highlight_group = vim.api.nvim_create_augroup("highlight_yank", {})
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = highlight_group,
    pattern = "*",
    callback = function() vim.highlight.on_yank { higroup = "Visual", timeout = 200 } end,
})

local filetype_mappings = vim.api.nvim_create_augroup("filetype_mapping", {})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = filetype_mappings,
    pattern = { "Jenkinsfile*" },
    command = "set filetype=groovy",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = filetype_mappings,
    pattern = { "injections.scm" },
    command = "set filetype=query",
})

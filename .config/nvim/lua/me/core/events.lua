local highlight_group = vim.api.nvim_create_augroup("highlight_yank", {})
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = highlight_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
    end,
})

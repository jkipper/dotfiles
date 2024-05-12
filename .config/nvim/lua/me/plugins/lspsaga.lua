return {
    {
        "nvimdev/lspsaga.nvim",
        branch = "main",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
            "nvim-lualine/lualine.nvim",
        },
        opts = {
            finder = { keys = { open = "<CR>", vsplit = "<C-V>", split = "<C-X>" } },
            symbol_in_winbar = { enable = true, hide_keyword = true },
        },
    },
    {
        "ray-x/lsp_signature.nvim",
        opts = { floating_window = false, hint_enable = false },
    },
}

local M = {}
vim.g.neoformat_enabled_python = { "black", "isort" }
vim.g.neoformat_enabled_toml = { "taplo" }

M.docs = {
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("neogen").setup {
            snippet_engine = "luasnip",
            languages = {
                python = {
                    template = {
                        annotation_convention = "reST",
                    },
                },
            },
        }
    end,
}

return M

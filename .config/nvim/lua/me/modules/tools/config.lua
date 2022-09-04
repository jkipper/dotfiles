local M = {}
vim.g.neoformat_enabled_python = { "black", "isort" }
vim.g.neoformat_enabled_toml = { "taplo" }
vim.g.neoformat_enabled_cpp = { "clang-format" }

M.docs = {
    requires = { ["nvim-treesitter"] = "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("neogen").setup {
            snippet_engine = "luasnip",
            languages = {
                python = {
                    template = {
                        annotation_convention = "google_docstrings",
                    },
                },
            },
        }
    end,
}

return M

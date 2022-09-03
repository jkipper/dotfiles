local M = {}
vim.g.neoformat_enabled_python = { "black", "isort" }
vim.g.neoformat_enabled_toml = { "taplo" }

M.docs = {
    deps = { ["nvim-treesitter"] = "nvim-treesitter/nvim-treesitter" },
    conf = function()
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

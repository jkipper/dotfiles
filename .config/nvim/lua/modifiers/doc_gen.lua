local g = vim.g

return function(use)
  use {
    "danymat/neogen",
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
      vim.keymap.set("n", "<leader>md", function()
        require("neogen").generate()
      end)
    end,
    requires = "nvim-treesitter/nvim-treesitter",
  }
end

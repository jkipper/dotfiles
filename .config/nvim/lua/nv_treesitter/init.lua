return function(use)
  use {
    "nvim-treesitter/nvim-treesitter",
    requires = { "andymass/vim-matchup", "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "cpp",
          "c",
          "bash",
          "lua",
          "python",
          "cmake",
          "comment",
          "jsonc",
          "yaml",
          "dockerfile",
        },
        highlight = { enable = true },
        matchup = {
          enable = true,
          disable_virtual_text = { "python" },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["il"] = "@loop.inner",
              ["al"] = "@loop.outer",
              ["ip"] = "@parameter.inner",
              ["ap"] = "@parameter.outer"
            }
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>s"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>S"] = "@parameter.inner",
            },
          },
        },
      }
    end,
  }
  use {
    "lewis6991/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {}
    end,
  }
end

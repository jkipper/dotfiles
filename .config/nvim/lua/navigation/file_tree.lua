return function(use)
  use {
    "nvim-neo-tree/neo-tree.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require "neo-tree".setup {
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_by_name = {
              ".git",
              "*.pyc$"
            },
            never_show = {
              ".DS_Store"
            },
          },
          follow_current_file = true,
          window = {
            mappings = {
              ["F"] = "clear_filter"
            }
          }
        },
        window = {
          mappings = {
            ["<C-V>"] = "open_vsplit",
            ["<C-X>"] = "open_split"
          }
        }
      }

      local keymap_opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<C-e>", "<cmd>NeoTreeFocusToggle<cr>", keymap_opts)
      vim.keymap.set("n", "<C-b>", "<cmd>NeoTreeFocusToggle buffers<cr>", keymap_opts)
    end
  }
end

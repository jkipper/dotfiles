return function(use)
  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup {
        options = {
          theme = "tokyonight",
        },
        extensions = { "neo-tree", "fugitive", "toggleterm", "nvim-dap-ui" },
      }
    end,
  }

  use {
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("bufferline").setup {
        options = {
          numbers = "none",
          separator_style = "thin",
          close_icon = "",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
            },
          },
        },
      }

      local keymap_opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<A-,>", function()
        require("bufferline").cycle(-1)
      end, keymap_opts)
      vim.keymap.set("n", "<A-.>", function()
        require("bufferline").cycle(1)
      end, keymap_opts)
    end,
  }
end

return function(use)
  use {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "neovim/nvim-lspconfig",
      "williamboman/nvim-lsp-installer",
      "onsails/lspkind-nvim",
    },
    config = function()
      require("completion.conf").cmp()
      require("completion.conf").lsp()
    end,
  }
  use { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" }
  use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
  use { "hrsh7th/cmp-path", after = "nvim-cmp" }
  use { "hrsh7th/cmp-cmdline", after = "nvim-cmp" }

  use {
    "hrsh7th/cmp-vsnip",
    after = "nvim-cmp",
    requires = {
      { "hrsh7th/vim-vsnip", after = "nvim-cmp" },
      { "rafamadriz/friendly-snippets", event = "InsertCharPre" },
    },
  }
  use {
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-cmp",
    config = function()
      require("completion.conf").diagnostic()
    end,
  }
end

return function(use)
  use "editorconfig/editorconfig-vim"
  vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*' }
  use "sickill/vim-pasta"
  use "tommcdo/vim-exchange"
  use { "glts/vim-radical", requires = { "glts/vim-magnum" } }
  use "tpope/vim-repeat"
  use "tpope/vim-surround"
  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {}
    end,
  }
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  }
  require "modifiers.doc_gen" (use)
  require "modifiers.formatter" (use)
end

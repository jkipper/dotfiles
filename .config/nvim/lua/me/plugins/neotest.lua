return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-python",
        { "nvim-neotest/nvim-nio" },
    },
    config = function()
        require("neotest").setup {
            adapters = { require "neotest-python", require "rustaceanvim.neotest" },
        }
    end,
}

return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        { "theHamsta/nvim-dap-virtual-text" },
        { "mfussenegger/nvim-dap" },
        { "nvim-neotest/nvim-nio" },
    },
    config = function()
        require("dapui").setup {}
        require("nvim-dap-virtual-text").setup {}
        vim.api.nvim_create_user_command("DapUiToggle", require("dapui").toggle, {})
    end,
}

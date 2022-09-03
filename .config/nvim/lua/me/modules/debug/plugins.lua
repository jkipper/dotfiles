return {
    dap = {
        "mfussenegger/nvim-dap",
        requires = { "theHamsta/nvim-dap-virtual-text", { "rcarriga/nvim-dap-ui", cmd = "DapUiToggle" } },
        cmd = "DapUiToggle",
        config = function()
            require("dapui").setup {}
            require("nvim-dap-virtual-text").setup {}
            vim.api.nvim_create_user_command("DapUiToggle", require("dapui").toggle, {})
        end,
    },
}

return function(use)
  vim.g.neoformat_enabled_python = { "black", "isort" }
  vim.g.neoformat_enabled_toml = {"taplo"}
  use { "sbdchd/neoformat", cmd = "Neoformat" }
end

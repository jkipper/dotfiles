local lsp_status = require"lsp-status"
lsp_status.register_progress()
print(lsp_status.status())

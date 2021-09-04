-- Lua Vim Config File

-- Imports
local lspconfig = require 'lspconfig'

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Default options
local opts = {
    capabilities = capabilities,
    init_options = { usePlaceholders = true, },
}

-- Set up LSP configurations
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
lspconfig.pyright.setup{opts}
lspconfig.vimls.setup{opts}
lspconfig.gopls.setup{opts}
lspconfig.dockerls.setup{opts}

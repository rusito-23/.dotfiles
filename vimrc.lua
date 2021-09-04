-- Lua Vim Config File

-- Load LSP configuration
local lspconfig = require 'lspconfig'

-- Set up LSP configurations
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
lspconfig.pyright.setup{}
lspconfig.vimls.setup{}
lspconfig.gopls.setup{}
lspconfig.dockerls.setup{}

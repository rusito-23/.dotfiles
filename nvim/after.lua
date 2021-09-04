-- Vim Plugin Configuration in Lua

-- Imports
local lspconfig = require 'lspconfig'
local protocol = require 'vim.lsp.protocol'
local saga = require 'lspsaga'
local treesitter = require 'nvim-treesitter'
local telescope = require 'telescope'
local actions = require 'telescope.actions'

-- Capabilities
local capabilities = protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Common LSP options
local opts = { capabilities = capabilities, init_options = { usePlaceholders = true } }

-- Set up LSP configurations
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
lspconfig.pyright.setup { opts }
lspconfig.vimls.setup { opts }
lspconfig.gopls.setup { opts }
lspconfig.dockerls.setup { opts }

-- Set up LSP Saga
saga.init_lsp_saga {
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
    border_style = "round",
}

-- Set up Tree Sitter

treesitter.setup {
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = false,
        disable = {}
    },
    ensure_installed = {}
}

-- Set up Telescope

telescope.setup {
    defaults = {
        mappings = {
            n = {
                -- Move between selections with vim keys
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            }
        }
    },
    pickers = {
        buffers = {
            mappings = {
                -- Easily delete buffers
                i = { ["<C-d>"] = actions.delete_buffer },
                n = { ["<C-d>"] = actions.delete_buffer }
            }
        }
    }
}

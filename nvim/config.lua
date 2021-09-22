--  ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗    ██╗     ██╗   ██╗ █████╗
-- ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝    ██║     ██║   ██║██╔══██╗
-- ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗   ██║     ██║   ██║███████║
-- ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║   ██║     ██║   ██║██╔══██║
-- ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝██╗███████╗╚██████╔╝██║  ██║
--  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
--
-- Author: Igor Andruskiewitsch
-- License: MIT
-- Notes: Neovim plugin configuration written in Lua

-- Vim Plugin Configuration in Lua
-- Imports
local lspconfig = require 'lspconfig'
local protocol = require 'vim.lsp.protocol'
local saga = require 'lspsaga'
local treesitter = require 'nvim-treesitter'
local telescope = require 'telescope'
local actions = require 'telescope.actions'
local completion = require 'completion'

-- Capabilities
local capabilities = protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Common LSP options
local default_opts = {
    capabilities = capabilities,
    init_options = { usePlaceholders = true },
}

-- Set up LSP configurations
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md

-- `npm install -g pyright`
lspconfig.pyright.setup {
    default_opts,
    on_attach = completion.on_attach
}

-- `npm install -g vim-language-server`
lspconfig.vimls.setup {
    default_opts,
    on_attach = completion.on_attach
}

-- `go get golang.org/x/tools/gopls@latest`
lspconfig.gopls.setup {
    default_opts,
    on_attach = completion.on_attach
}

-- `npm install -g dockerfile-language-server-nodejs`
lspconfig.dockerls.setup {
    default_opts,
    on_attach = completion.on_attach
}

-- `cargo install --git https://github.com/latex-lsp/texlab.git --locked`
lspconfig.texlab.setup{
    default_opts,
    on_attach = completion.on_attach
}

-- `brew install rust-analyzer`
lspconfig.rust_analyzer.setup{
    default_opts,
    on_attach = completion.on_attach
}

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
            -- Move between selections with vim keys
            -- in Normal mode
            n = {
                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
            },
            -- Move between selections with C + vim keys
            -- in Insert mode
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
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

-- Disable completion for Telescope

vim.g.completion_chain_complete_list = {
	default = {
		{ complete_items = { "lsp", "path", "buffers", "snippet" } },
		{ mode = "<C-p>" },
		{ mode = "<C-n>" },
	},
	TelescopePrompt = {},
	frecency = {},
}

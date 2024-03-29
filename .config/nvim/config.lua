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
local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local cmp = require 'cmp'

-- Capabilities
local default_capabilities = protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.default_capabilities(default_capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Default On Attach
local default_on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
end

-- Default LSP options

local default_opts = {
    flags = { debounce_text_changes = 75 },
    capabilities = capabilities,
    init_options = { usePlaceholders = true },
    on_attach = default_on_attach
}

lspconfig.util.default_config = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config,
  default_opts
)

-- Set up LSP configurations
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- `npm install -g pyright`
lspconfig.pyright.setup {}

-- `npm install -g vim-language-server`
lspconfig.vimls.setup {}

-- `go get golang.org/x/tools/gopls@latest`
lspconfig.gopls.setup {}

-- `npm install -g dockerfile-language-server-nodejs`
lspconfig.dockerls.setup {}

-- `cargo install --git https://github.com/latex-lsp/texlab.git --locked`
lspconfig.texlab.setup{}

-- `brew install rust-analyzer`
lspconfig.rust_analyzer.setup{}

-- `npm i -g vscode-langservers-extracted`
lspconfig.eslint.setup{}

-- `npm i -g emmet-ls`
lspconfig.emmet_ls.setup{}

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

-- Completion configuration

local on_tab = function(fallback)
    local col = vim.fn.col('.') - 1
    if cmp.visible() then
        cmp.select_next_item(select_opts)
    else
        fallback()
    end
end

local on_s_tab = function(fallback)
    if cmp.visible() then
        cmp.select_prev_item(select_opts)
    else
        fallback()
    end
end

cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'vsnip' },
    },
    mapping = {
        ['<Tab>'] = cmp.mapping(on_tab, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(on_s_tab, {'i', 's'}),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }
})

--- Diagnostics config

vim.diagnostic.config({virtual_text = false})
vim.o.updatetime = 250

-- LSP Auto-commands

vim.api.nvim_create_autocmd('User', {
  pattern = 'LspAttached',
  desc = 'LSP Actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')                -- Show information
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')          -- Go to Definition
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')          -- List references
    bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')   -- Show arguments
    bufmap('n', 'rr', '<cmd>lua vim.lsp.buf.rename()<cr>')              -- Rename symbol
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')       -- Show diagnostics
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')        -- Next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')        -- Previous diagnostic
  end
})

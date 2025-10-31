" ██████╗ ██╗     ██╗   ██╗ ██████╗   ██╗   ██╗██╗███╗   ███╗
" ██╔══██╗██║     ██║   ██║██╔════╝   ██║   ██║██║████╗ ████║
" ██████╔╝██║     ██║   ██║██║  ███╗  ██║   ██║██║██╔████╔██║
" ██╔═══╝ ██║     ██║   ██║██║   ██║  ╚██╗ ██╔╝██║██║╚██╔╝██║
" ██║     ███████╗╚██████╔╝╚██████╔╝██╗╚████╔╝ ██║██║ ╚═╝ ██║
" ╚═╝     ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝ ╚═══╝  ╚═╝╚═╝     ╚═╝
"
" Author: Igor Andruskiewitsch
" License: MIT
" Notes: `plug.vim` plugins configuration

" {{{ plug.vim Installation

let data_dir = has('nvim') ? stdpath('data').'/site' : '~/.vim'
let plugged_dir = has('nvim') ? stdpath('data').'/plugged' : '~/.vim'
let plugin_url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs '.plugin_url
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" }}}

call plug#begin(plugged_dir)

" Navigation utils
Plug 'preservim/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/vim-peekaboo'

" Telescope fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Git management
Plug 'tpope/vim-fugitive'

" Code helpers
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'

" Language support
Plug 'MTDL9/vim-log-highlighting'
Plug 'dart-lang/dart-vim-plugin'
Plug 'keith/swift.vim'

" Color schemes
Plug 'arcticicestudio/nord-vim'
Plug 'navarasu/onedark.nvim'

" LSP
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'tami5/lspsaga.nvim'

" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" LSP Snippets
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'hrsh7th/cmp-vsnip'

" Tree-sitter
Plug 'nvim-treesitter/nvim-treesitter'

" AI
Plug 'github/copilot.vim'

call plug#end()

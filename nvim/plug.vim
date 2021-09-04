" ----------------------------------------------------------------------------
" Plugin Management
" ----------------------------------------------------------------------------

" Install dein if needed
if empty(glob('~/.dotfiles/dein'))
  silent !curl
              \ https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh
              \ > dein_installer.sh
              \ 2> /dev/null
    silent !sh ./dein_installer.sh ~/.dotfiles/dein > /dev/null
    silent !rm dein_installer.sh
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Configure runtime path
let g:python3_host_prog="~/.virtualenvs/nvim/bin/python"
set runtimepath+=~/.dotfiles/dein/repos/github.com/Shougo/dein.vim
set rtp+=/usr/local/opt/fzf

if dein#load_state('~/.dotfiles/dein')
  call dein#begin('~/.dotfiles/dein')
  call dein#add('~/.dotfiles/dein/repos/github.com/Shougo/dein.vim')

  " Navigation
  call dein#add('preservim/nerdtree')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('majutsushi/tagbar')
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('kshenoy/vim-signature')
  call dein#add('junegunn/vim-peekaboo')
  call dein#add('severin-lemaignan/vim-minimap')

  " Fuzzy finder
  call dein#add('nvim-lua/plenary.nvim')
  call dein#add('nvim-telescope/telescope.nvim')

  " Code Completion
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('ncm2/float-preview.nvim')
  call dein#add('deoplete-plugins/deoplete-lsp')

  " Specific Language Completions
  call dein#add('zchee/deoplete-jedi')
  call dein#add('davidhalter/jedi-vim')
  call dein#add('dart-lang/dart-vim-plugin')
  call dein#add('keith/swift.vim')

  " LSP
  call dein#add('neovim/nvim-lsp')
  call dein#add('neovim/nvim-lspconfig')
  call dein#add('glepnir/lspsaga.nvim')

  " Tree-sitter
  call dein#add('nvim-treesitter/nvim-treesitter')

  " Snippets
  call dein#add('rafamadriz/friendly-snippets')
  call dein#add('hrsh7th/vim-vsnip')
  call dein#add('hrsh7th/vim-vsnip-integ')

  " vim-airline
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  " Code Style
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('sbdchd/neoformat')
  call dein#add('tpope/vim-surround')
  call dein#add('MTDL9/vim-log-highlighting')
  call dein#add('tpope/vim-abolish')

  " Code Checker
  call dein#add('neomake/neomake')

  " Color Schemes
  call dein#add('joshdick/onedark.vim')
  call dein#add('gilgigilgil/anderson.vim')
  call dein#add('wadackel/vim-dogrun')
  call dein#add('arcticicestudio/nord-vim')

  " Git
  call dein#add('tpope/vim-fugitive')

  call dein#end()
  call dein#save_state()
endif

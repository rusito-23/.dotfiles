" Vim Script Config File
" Notes: Only works for `neovim`

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dein Plugin Manager Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
  call dein#add('kien/ctrlp.vim')
  call dein#add('kshenoy/vim-signature')
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('junegunn/vim-peekaboo')
  call dein#add('severin-lemaignan/vim-minimap')

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set cursorline                  " Highlight the current line
set clipboard+=unnamedplus      " Use the system clipboard
set mouse=a                     " Enable mouse interaction
set scrolloff=3                 " When scrolling, use an offset of three lines
syntax on                       " Enable syntax
set noshowmode                  " Remove default mode indicator
set hlsearch incsearch          " Highlight matches and patterns
set ignorecase smartcase        " Define search case matching
set nu rnu                      " Use relative line numbers
set diffopt+=vertical           " Use vertical diff

" Default tab configuration
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Define the map leader
let g:mapleader = ","

" Configure Indentation
filetype on
filetype plugin on
filetype indent on
set autoindent

" Special characters display configuration
set list
set showbreak=↪\
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:↲,precedes:«,extends:»

" Configure completion options
set completeopt+=menuone   " Show the pop up menu even when there is only 1 match
set completeopt+=noinsert  " Don't insert any text until user chooses a match
set completeopt+=noselect  " Don't select the first option automatically
set completeopt-=longest   " Don't insert the longest common text
set completeopt+=preview   " Show docs in V split
set belloff+=ctrlg         " Don't beep during completion

" Enable and configure spell check
set spell spelllang=en_us
set spellfile=~/.dotfiles/spell/spellcheck.utf-8.add

" Enable `deoplete` on start up
let g:deoplete#enable_at_startup = 1

" Enable `deoplete` LSP
let g:deoplete#lsp#handler_enabled = 1
let g:deoplete#lsp#use_icons_for_candidates = 1

" Enable `kite` plugin if available
let g:kite_tab_complete=1

" Airline status bar configuration
let g:airline_theme='nord'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0

" `neoformat` configuration
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1

" `neomake` configuration
let g:neomake_python_enabled_makers = ['pycodestyle']
call neomake#configure#automake('nrwi', 500)

" `vim-tmux-navigator` configuration
let g:tmux_navigator_no_mappings = 1

" Configure Ctrl-P to show hidden files
let g:ctrlp_show_hidden = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load Lua Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

luafile ~/.dotfiles/nvim/lsp.lua

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto-commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use tabs for Go Lang files
autocmd FileType go exec 'set noexpandtab shiftwidth=8'

" Use 2 spaces for JSON, YAML and TOML files
autocmd FileType yaml exec 'set shiftwidth=2'
autocmd FileType toml exec 'set shiftwidth=2'
autocmd FileType json exec 'set shiftwidth=2'

" Set up column wrapping
autocmd FileType gitcommit exec 'set colorcolumn=50'
autocmd FileType python exec 'set colorcolumn=80'
autocmd FileType swift exec 'set colorcolumn=120'

" Remove trailing white spaces when a file is saved
autocmd BufWritePre * call RemoveTrailingWhitespaces()

" Display NERD Tree when opening an empty buffer
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close floating completion pop-up when a selection is made
autocmd CompleteDone * if !pumvisible() | pclose | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Spellchecker colors
hi clear SpellBad
hi clear SpellCap
hi clear SpellLocal
hi SpellBad cterm=underline ctermfg=red
hi SpellCap cterm=underline ctermfg=yellow
hi SpellLocal cterm=underline ctermfg=yellow

" Color scheme
set termguicolors
colorscheme nord

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Clear all trailing white spaces in the file
function! RemoveTrailingWhitespaces()
    let l:saved_position = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:saved_position)
endfunction

" Execute macro without dropping the visual range
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Load templates into the current buffer
" Example: LoadTemplate("py") will load ~/.dotfiles/templates/template.py
function! LoadTemplate(ext)
    execute "r ~/.dotfiles/templates/template." . a:ext
endfunction

" Create command with the file extension to load a template
" Example: SetUpTemplate("py") will create the command :py
function! SetUpTemplate(ext)
    execute "cnoreabbrev ".a:ext." :call LoadTemplate('".a:ext."')"
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Prevent some common typos
command! W :w
command! Wqa :wqa
command! Q :q
command! Qa :qa

" Reload the config file
command! Source :source ~/.dotfiles/vimrc | noh | set nospell

" Capitalize the given selection
command! -range Caps <line1>,<line2>s/\<./\u&/g | noh

" General code finder in current file mapping with preview
" See: https://github.com/junegunn/fzf.vim/issues/374
command! -bang -nargs=* BLinesWithPreview
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --color=always --smart-case . '.fnameescape(expand('%')), 1,
    \   fzf#vim#with_preview({'options': '--delimiter : --nth 4.. --no-sort'}, 'right:50%', '?'), 1)

" General code finder in all files mapping with preview
" See: https://github.com/junegunn/fzf.vim/issues/374
command! -bang -nargs=* LinesWithPreview
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --color=always --smart-case . ', 1,
    \   fzf#vim#with_preview({'options': '--delimiter : --nth 4.. --no-sort'}, 'right:50%', '?'), 1)

" Create extension command for each available template
call map(globpath('~/.dotfiles/templates/', '*', 1, 1), 'SetUpTemplate(fnamemodify(v:val, ":e"))')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Close file without saving
nnoremap XX :qa!<CR>

" Navigate using the display lines
nnoremap j gj
nnoremap k gk

" Save the current file
nnoremap <leader>s :update<CR>

" Clear highlights with <CR>
nnoremap <CR> :noh<CR>

" Execute the macro `q`
nnoremap <Space> @q

" Clear all buffers
nnoremap <leader>cab :w <bar> %bd <bar> e# <bar> bd# <CR><CR>

" Execute macro over visual range
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" Toggle NERD Tree
nnoremap <C-n> :NERDTreeToggle<CR>

" Toggle Tagbar
nnoremap <C-t> :TagbarToggle<CR>

" Trigger `deoplete` -> TODO: Does this work?
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Navigate between panes
" See: https://github.com/christoomey/vim-tmux-navigator
nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
nnoremap <silent> <M-l> :TmuxNavigateRight<CR>

" Create vertical pane
nnoremap <M-.> :vsp<return><esc>

" Create horizontal pane
nnoremap <M-,> :sp<return><esc>

" Search files with `fzf`
nnoremap <leader>e :Files<CR>

" Search lines in the current file with `fzf`
nnoremap <leader>f :BLines<CR>

" Search lines in the current file with preview with `fzf`
nnoremap <leader>fp :BLinesWithPreview<CR>

" Search lines in all files with `fzf`
nnoremap <leader>F :LinesWithPreview<CR>

" Search commands with `fzf`
nnoremap <leader>c :Commands<CR>

" Search windows with `fzf`
nnoremap <leader>w :Windows<CR>

" Expand or jump LSP snippets if possible
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward between LSP snippets if possible
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Tab completion navigation
inoremap <silent><expr><Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <silent><expr><S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"

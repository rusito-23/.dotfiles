" vimrc
" My neovim config file

""""""""""""""""""""""""""""""
" dein Config

let g:python3_host_prog="~/.virtualenvs/nvim/bin/python"
set runtimepath+=~/.dotfiles/dein/repos/github.com/Shougo/dein.vim
set rtp+=/usr/local/opt/fzf

if dein#load_state('~/.dotfiles/dein')
  call dein#begin('~/.dotfiles/dein')
  call dein#add('~/.dotfiles/dein/repos/github.com/Shougo/dein.vim')

  " navigation
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

  " code completion
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-jedi')
  call dein#add('davidhalter/jedi-vim')
  call dein#add('dart-lang/dart-vim-plugin')
  call dein#add('keith/swift.vim')
  call dein#add('ncm2/float-preview.nvim')

  " lsp
  call dein#add('neovim/nvim-lsp')
  call dein#add('hrsh7th/vim-vsnip')
  call dein#add('rafamadriz/friendly-snippets')

  " vim-airline
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  " code style
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('sbdchd/neoformat')
  call dein#add('tpope/vim-surround')
  call dein#add('MTDL9/vim-log-highlighting')
  call dein#add('tpope/vim-abolish')

  " code checker
  call dein#add('neomake/neomake')

  " color schemes
  call dein#add('joshdick/onedark.vim')
  call dein#add('gilgigilgil/anderson.vim')
  call dein#add('wadackel/vim-dogrun')

  " git diff & merge tools
  call dein#add('tpope/vim-fugitive')

  call dein#end()
  call dein#save_state()
endif


""""""""""""""""""""""""""""""
" General Config

command! W :w                   " Prevent `:W` typo
" Navigation using the display lines
nnoremap j gj
nnoremap k gk
" Shortcut to save the file
nnoremap <leader>s :update<CR>

set cursorline                  " Highlight the current line
set clipboard+=unnamedplus      " Use the system clipboard
set mouse=a                     " Enable mouse interaction
set scrolloff=3                 " When scrolling, use an offset of three lines
syntax on                       " Enable syntax
set noshowmode                  " Remove default mode indicator

set hlsearch incsearch          " Highlight matches and patterns
set ignorecase smartcase        " Define search case matching
" Clear search with <CR>
nnoremap <cr> :noh<cr>

" Execute the macro `q` with the spacebar
nnoremap <Space> @q
" Clear all buffers
nnoremap <leader>cab :w <bar> %bd <bar> e# <bar> bd# <CR><CR>

" Define the map leader as `,`
let mapleader = ","
let g:mapleader = ","

" Show both the current line number and the relative line number
set number relativenumber
set nu rnu

" Default tab configuration
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Go files won't use spaces
autocmd FileType go exec 'set noexpandtab shiftwidth=8'

" JSON, YAML and TOML files should use 2 spaces
autocmd FileType yaml exec 'set shiftwidth=2'
autocmd FileType toml exec 'set shiftwidth=2'
autocmd FileType json exec 'set shiftwidth=2'

" Indentation configuration
filetype on
filetype plugin on
filetype indent on
set autoindent

" Set up column wrapping
autocmd FileType gitcommit exec 'set colorcolumn=50'
autocmd FileType python exec 'set colorcolumn=80'
autocmd FileType swift exec 'set colorcolumn=120'

" Display special characters
set list
set showbreak=↪\
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:↲,precedes:«,extends:»

" Configure spell check with custom highlight colors
set spell spelllang=en_us
set spellfile=~/.dotfiles/spellcheck.utf-8.add
hi clear SpellBad
hi clear SpellCap
hi clear SpellLocal
hi SpellBad cterm=underline ctermfg=red
hi SpellCap cterm=underline ctermfg=yellow
hi SpellLocal cterm=underline ctermfg=yellow

" Remove trailing whitespace when a file is saved
function! RemoveTrailingWhitespaces()
    let l:saved_position = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:saved_position)
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespaces()

" Prevent macro execution drop with visual range
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Define the color scheme
colorscheme dogrun

"""""""""""""""""""""""""""""""
" Custom Plugin Configuration

" Display NERD Tree when opening an empty buffer
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Toggle NERD Tree using `C-N`
map <C-n> :NERDTreeToggle<CR>

" Toggle Tagbar using `C-T`
nmap <C-t> :TagbarToggle<CR>

" Enable `deoplete` on start up
let g:deoplete#enable_at_startup = 1
" Trigger `deoplete` with `TAB`
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Configure airline status bar
let g:airline_theme='dark_minimal'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0

" Configure neoformat
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1

" Configure neomake
let g:neomake_python_enabled_makers = ['pycodestyle']
call neomake#configure#automake('nrwi', 500)


" Configure the vim-tmux-navigator config
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>

" Create a vertical pane with `M-.`
nnoremap <M-.> :vsp<return><esc>

" Create a horizontal pane with `M-,`
nnoremap <M-,> :sp<return><esc>

" Configure Ctr-P to show hidden files
let g:ctrlp_show_hidden = 1

" Configure nvim-fugitive to use vertical diff
set diffopt+=vertical

" Configure `fzf` plugin
" Taken and modified from:
" https://github.com/fisadev/fisa-vim-config

" Search files
nnoremap <leader>e :Files<CR>
" Search lines in the current file
nnoremap <leader>f :BLines<CR>
" Search lines in all files
nnoremap <leader>F :Lines<CR>
" Search for nvim commands
nnoremap <leader>c :Commands<CR>

" General code finder in current file mapping with preview
" https://github.com/junegunn/fzf.vim/issues/374
command! -bang -nargs=* BLinesWithPreview
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --color=always --smart-case . '.fnameescape(expand('%')), 1,
    \   fzf#vim#with_preview({'options': '--delimiter : --nth 4.. --no-sort'}, 'right:50%', '?'), 1)
nnoremap <leader>pf :BLinesWithPreview<CR>

" General code finder in all files mapping with preview
" https://github.com/junegunn/fzf.vim/issues/374
command! -bang -nargs=* LinesWithPreview
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --color=always --smart-case . ', 1,
    \   fzf#vim#with_preview({'options': '--delimiter : --nth 4.. --no-sort'}, 'right:50%', '?'), 1)
nnoremap <leader>pF :LinesWithPreview<CR>

" Configure `kite` plugin
let g:kite_tab_complete=1
set completeopt+=menuone   " show the pop up menu even when there is only 1 match
set completeopt+=noinsert  " don't insert any text until user chooses a match
set completeopt-=longest   " don't insert the longest common text
set completeopt+=preview
autocmd CompleteDone * if !pumvisible() | pclose | endif
set belloff+=ctrlg  " if nvim beeps during completion
set completeopt-=preview   " prevent nvim from showing docs in V split

""""""""""""""""""""""""""""""
" Custom Templates

command PyScript r ~/.dotfiles/templates/pyscript.py
command ShScript r ~/.dotfiles/templates/shscript.sh

""""""""""""""""""""""""""""""
" Set up LSP snippets

" Edit snips settings
set signcolumn=yes " TODO: Find out what does this stuff is
let g:completion_enable_snippet = 'vim-vsnip'

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

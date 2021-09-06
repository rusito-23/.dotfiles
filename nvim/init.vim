" init.vim

" {{{ Load external files

source ~/.dotfiles/nvim/plug.vim
luafile ~/.dotfiles/nvim/config.lua

" }}}

" {{{ Options

scriptencoding utf-8                    " set script encoding
set nocompatible                        " The future is now old man
set diffopt+=vertical                   " Use vertical diff
set cursorline                          " Highlight the current line
set clipboard+=unnamedplus              " Use the system clipboard
set mouse=a                             " Enable mouse interaction
set scrolloff=3                         " When scrolling, use an offset of three lines
set noshowmode                          " Remove default mode indicator
set hlsearch incsearch                  " Highlight matches and patterns
set ignorecase smartcase incsearch      " Define search case matching
set nu rnu                              " Use relative line numbers
set path +=**                           " Kind of a fuzzy finder
set foldmethod=indent                   " Default fold method is using the syntax
set foldlevel=0                         " Automatically enable folds
set foldtext=FoldText()                 " Show custom fold text
set hid                                 " Buffers get hidden when abandoned
set backspace=eol,start,indent          " Don't mess with my backspace
set whichwrap+=<,>,h,l                  " Wrap around the characters when selecting
set lazyredraw                          " Macro optimization
set foldcolumn=1                        " Some left margin right here

" Wild menu configuration
set wildmenu                            " Display matching files on tab complete
set wildmode=longest,list,full          " Wild menu configuration

" Default tab configuration
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Define the map leader
let g:mapleader = ","

syntax on                               " Enable syntax
filetype on                             " Enable file type matching
filetype plugin on                      " Enable plugins

" Configure Indentation
filetype indent on
set autoindent smartindent

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
set spellfile=~/.dotfiles/nvim/spell/spellcheck.utf-8.add

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

" }}}

" {{{ Auto-commands

" Use tabs for Go Lang files
autocmd FileType go exec 'set noexpandtab shiftwidth=8'

" Use 2 spaces for JSON, YAML, TOML files
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

" Set up fold method marker for specific files
autocmd FileType vim exec 'set foldmethod=marker'
autocmd FileType zsh exec 'set foldmethod=marker'
autocmd FileType sh exec 'set foldmethod=marker'
autocmd FileType tmux exec 'set foldmethod=marker'

" }}}

" {{{ Colors

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

" }}}

" {{{ Functions

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
" Example: SetUpTemplate("py") will create the command :Py
function! SetUpTemplate(ext)
    execute "command! ".toupper(a:ext)." call LoadTemplate('".a:ext."')"
endfunction

function! FoldText()
    let line = getline(v:foldstart)
    let folded_line_num = v:foldend - v:foldstart
    let line_text = substitute(line, '^.*{{{\+', '', 'g')
    let fillcharcount = &textwidth - len(line_text) - len(folded_line_num)
    return '+'. repeat('-', 4) . line_text . repeat('.', fillcharcount) . ' (' . folded_line_num . ' L)'
    # dumb marker closer }}}
endfunction

" }}}

" {{{ Commands

" Prevent some common typos
command! W :w
command! Wqa :wqa
command! Q :q
command! Qa :qa

" Reload the config file
command! Source :source ~/.config/nvim/init.vim | noh | set nospell

" Install or update dein plugins
command! DeinInstall :source ~/.config/nvim/init.vim | noh | set nospell | call dein#install()
command! DeinUpdate :source ~/.config/nvim/init.vim | noh | set nospell | call dein#update()

" Capitalize the given selection
command! -range Caps <line1>,<line2>s/\<./\u&/g | noh

" Create extension command for each available template
call map(globpath('~/.dotfiles/templates/', '*', 1, 1), 'SetUpTemplate(fnamemodify(v:val, ":e"))')

" }}}

" {{{ Mappings

" Close file without saving
nnoremap XX :qa!<CR>

" Navigate using the display lines
nnoremap j gj
nnoremap k gk

" Save the current file
nnoremap <leader>s :update<CR>

" Clear highlights with <CR> or <ESC>
nnoremap <CR> :noh<CR>
nnoremap <ESC> :noh<CR>

" Execute the macro `q`
nnoremap <Space> @q

" Execute macro over visual range
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" Toggle NERD Tree
nnoremap <C-n> :NERDTreeToggle<CR>

" Toggle Tagbar
nnoremap <C-t> :TagbarToggle<CR>

" Navigate between panes
" See: https://github.com/christoomey/vim-tmux-navigator
nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
nnoremap <silent> <M-l> :TmuxNavigateRight<CR>

" Create vertical and horizontal panes
nnoremap <M-.> :vsp<return><esc>
nnoremap <M-,> :sp<return><esc>

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

" Navigate completion menu with Tab
inoremap <silent><expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Prevent new line inserted after selecting a completion
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

" Mappings for Telescope command-line sugar.
nnoremap <leader>f <cmd>Telescope current_buffer_fuzzy_find<CR>
nnoremap <leader>e <cmd>Telescope find_files<CR>
nnoremap <leader>F <cmd>Telescope live_grep<CR>
nnoremap <leader>b <cmd>Telescope buffers<CR>
nnoremap <leader>H <cmd>Telescope help_tags<CR>

" Search the current selection with Telescope
vnoremap <leader>f "zy:Telescope current_buffer_fuzzy_find default_text=<C-R>z<CR>
vnoremap <leader>e "zy:Telescope find_files default_text=<C-R>z<CR>
vnoremap <leader>F "zy:Telescope live_grep default_text=<C-R>z<CR>

" Use * to search the current selection
vnoremap <silent> * "zy/<C-R>=@z<CR><CR>

" Mappings for LSP saga
nnoremap <silent> <C-j> <Cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent>K <Cmd>Lspsaga hover_doc<CR>
inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>

" }}}

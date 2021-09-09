
" ██╗███╗   ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
" ██║████╗  ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
" ██║██╔██╗ ██║██║   ██║   ██║   ██║██║██╔████╔██║
" ██║██║╚██╗██║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
" ██║██║ ╚████║██║   ██║██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
" ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
"
" Author: Igor Andruskiewitsch
" License: MIT
" Notes: My Neovim Configuration File

" {{{ Load external files

source ~/.dotfiles/nvim/plug.vim
source ~/.dotfiles/nvim/todo.vim
source ~/.dotfiles/nvim/status.vim
luafile ~/.dotfiles/nvim/config.lua

" }}}

" {{{ Options

" {{{ General Options

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
set splitbelow splitright               " Open below and on the right side
set showtabline=2                       " Always show tab line
set laststatus=2                        " Always show the status line
syntax on                               " Enable syntax
filetype on                             " Enable file type matching
filetype plugin on                      " Enable plugins
let g:mapleader = ","                   " Define map leader

" }}}

" {{{ Wild menu configuration

set wildmenu                            " Display matching files on tab complete
set wildmode=longest,list,full          " Wild menu configuration

" }}}

" {{{ Default tab configuration

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" }}}

" {{{ Configure Indentation

filetype indent on
set autoindent smartindent

" }}}

" {{{ Special characters display configuration

set list
set showbreak=↪\
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:↲,precedes:«,extends:»

" }}}

" {{{ Completion options

set completeopt+=menuone   " Show the pop up menu even when there is only 1 match
set completeopt+=noinsert  " Don't insert any text until user chooses a match
set completeopt+=noselect  " Don't select the first option automatically
set completeopt-=longest   " Don't insert the longest common text
set completeopt+=preview   " Show docs in V split
set belloff+=ctrlg         " Don't beep during completion

" }}}

" {{{ Configure spell check

set spell spelllang=en_us
set spellfile=~/.dotfiles/nvim/spell/spellcheck.utf-8.add

" }}}

" {{{ Configure plugins

" `vim-tmux-navigator` configuration
let g:tmux_navigator_no_mappings = 1

" Enable snippet completion
let g:completion_enable_snippet = 'vim-vsnip'

" }}}

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

" Vim-Fugitive Special Colors
hi DiffAdd gui=NONE guifg=green guibg=NONE
hi DiffDelete gui=NONE guifg=red guibg=NONE
hi DiffChange gui=NONE guifg=yellow guibg=NONE

" Status line colors
hi statusline   ctermfg=black   ctermbg=cyan    guifg=black     guibg=#8fbfdc
hi User1        ctermfg=cyan    ctermbg=239     guifg=#8fbfdc   guibg=#4e4e4e
hi User2        ctermfg=007     ctermbg=239     guifg=#cdcdcd    guibg=#4e4e4e
hi User3        ctermfg=cyan    ctermbg=239     guifg=#8fbfdc   guibg=#4e4e4e
hi User4        ctermfg=007     ctermbg=239     guifg=#adadad    guibg=#4e4e4e

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
" Example: LoadTemplate("py") will load ~/.dotfiles/templates/skeleton.py
function! LoadTemplate(ext)
    execute "r ~/.dotfiles/templates/skeleton." . a:ext
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

" Opens a small terminal at the bottom
function! OpenTerminal()
    split term://zsh
    resize 10
    normal! i
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

" Clear highlights with <CR>
nnoremap <CR> :noh<CR>

" Execute the macro `q`
nnoremap <Space> @q

" Execute macro over visual range
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" Toggle NERD Tree
nnoremap <C-n> :NERDTreeToggle<CR>

" Navigate between panes
" See: https://github.com/christoomey/vim-tmux-navigator
nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
nnoremap <silent> <M-l> :TmuxNavigateRight<CR>

" Create vertical and horizontal panes
nnoremap <M-.> :vsp<return><ESC>
nnoremap <M-,> :sp<return><ESC>

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
nnoremap <silent> <C-j> <cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent>K <cmd>Lspsaga hover_doc<CR>
inoremap <silent> <C-k> <cmd>Lspsaga signature_help<CR>
nnoremap <silent> gh <cmd>Lspsaga lsp_finder<CR>

" Open a small terminal at the bottom
nnoremap <silent> <leader>t  <cmd>call OpenTerminal()<CR>

" }}}

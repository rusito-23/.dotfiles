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

" {{{ Initial Options

scriptencoding utf-8                    " set script encoding
set nocompatible                        " The future is now old man
syntax on                               " Enable syntax
filetype on                             " Enable file type matching
filetype plugin on                      " Enable plugins

" }}}

" {{{ Load external files

source ~/.dotfiles/nvim/plug.vim
source ~/.dotfiles/nvim/todo.vim
source ~/.dotfiles/nvim/colors.vim
source ~/.dotfiles/nvim/statusline.vim
source ~/.dotfiles/nvim/tabline.vim
luafile ~/.dotfiles/nvim/config.lua

" }}}

" {{{ Options

" {{{ General Options

set diffopt+=vertical                   " Use vertical diff
set cursorline                          " Highlight the current line
set clipboard+=unnamedplus              " Use the system clipboard
set mouse=a                             " Enable mouse interaction
set scrolloff=3                         " When scrolling, use an offset of three lines
set noshowmode                          " Remove default mode indicator
set hlsearch incsearch                  " Highlight matches and patterns
set ignorecase smartcase incsearch      " Define search case matching
set nu rnu                              " Use relative line numbers
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
set notitle noicon                      " Never show title or icon

let g:mapleader = ","                   " Define map leader

" }}}

" {{{ Wild menu configuration

set wildmode=full       " Wild mode pop up configuration
set path +=**           " Kind of a fuzzy finder

" }}}

" {{{ Configure Indentation

set tabstop=8 softtabstop=4 expandtab shiftwidth=4 smarttab
filetype indent on
set autoindent smartindent

" }}}

" {{{ Special characters display configuration

set list
let &showbreak='↪ '
let &listchars='tab:→ ,space:·,nbsp:␣,trail:•,eol:↲,precedes:«,extends:»'

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

augroup CustomTabs
    " Use tabs for Go Lang files
    autocmd FileType go set noexpandtab tabstop=4 shiftwidth=8

    " Use 2 spaces for some files
    autocmd FileType css  set shiftwidth=2
    autocmd FileType yaml set shiftwidth=2
    autocmd FileType toml set shiftwidth=2
    autocmd FileType json set shiftwidth=2
    autocmd FileType javascript set shiftwidth=2
    autocmd FileType javascriptreact  set shiftwidth=2

    " Use tabs with 4 spaces for eBay files
    autocmd BufRead,BufNewFile */ios_core/*/*.swift setlocal noexpandtab tabstop=4 shiftwidth=4
    autocmd BufRead,BufNewFile */ios_core/*/*.h     setlocal noexpandtab tabstop=4 shiftwidth=4
    autocmd BufRead,BufNewFile */ios_core/*/*.m     setlocal noexpandtab tabstop=4 shiftwidth=4
augroup end

" Set up column wrapping
augroup ColumnWrapping
    autocmd FileType gitcommit set colorcolumn=50
    autocmd FileType python set colorcolumn=80
    autocmd FileType swift set colorcolumn=120
augroup end

" Remove trailing white spaces when a file is saved
augroup RemoveTrailingWhitespaces
    autocmd BufWritePre * call RemoveTrailingWhitespaces()
augroup end

" Display NERD Tree when opening an empty buffer
augroup AutoNERDTree
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup end

" Set up fold method marker for specific files
augroup FoldMethods
    autocmd FileType vim set foldmethod=marker
    autocmd FileType zsh set foldmethod=marker
    autocmd FileType sh set foldmethod=marker
    autocmd FileType tmux set foldmethod=marker
augroup end

" Configure Term
augroup ConfigureTerm
    autocmd TermOpen * setlocal nospell nonumber norelativenumber nocursorline
augroup end

" Display diagnostics automatically on cursor hold
"autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})

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

" Get the current syntax group under the cursor
" See: https://stackoverflow.com/a/58244921/8189455
function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
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

" Activate window mode more quickly
nnoremap <leader>w <C-w>

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

" Mappings for Telescope command-line sugar.
nnoremap <leader>f <cmd>Telescope current_buffer_fuzzy_find<CR>
nnoremap <leader>e <cmd>Telescope find_files<CR>
nnoremap <leader>h <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>i <cmd>Telescope find_files no_ignore=true<cr>
nnoremap <leader>F <cmd>Telescope live_grep<CR>
nnoremap <leader>b <cmd>Telescope buffers<CR>
nnoremap <leader>H <cmd>Telescope help_tags<CR>

" Search the current selection with Telescope
vnoremap <leader>f "zy:Telescope current_buffer_fuzzy_find default_text=<C-R>z<CR>
vnoremap <leader>e "zy:Telescope find_files default_text=<C-R>z<CR>
vnoremap <leader>h "zy:Telescope find_files hidden=true default_text=<C-R>z<CR>>
vnoremap <leader>F "zy:Telescope live_grep default_text=<C-R>z<CR>

" Use <leader>r to quickly replace a selection
xnoremap <leader>r y<Esc>:%s/<C-R>"//gc<Left><Left><Left>

" Use * to search the current selection
vnoremap <silent> * "zy/<C-R>=@z<CR><CR>

" Mappings for LSP saga
nnoremap <silent> <C-j> <cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent>K <cmd>Lspsaga hover_doc<CR>
inoremap <silent> <C-k> <cmd>Lspsaga signature_help<CR>
nnoremap <silent> gh <cmd>Lspsaga lsp_finder<CR>

" Open a small terminal at the bottom
nnoremap <silent> <leader>t  <cmd>call OpenTerminal()<CR>

" Back to normal mode using <Esc> in the terminal
tnoremap <Esc> <C-\><C-n>

" Never select the line break
vnoremap $ $h

" }}}

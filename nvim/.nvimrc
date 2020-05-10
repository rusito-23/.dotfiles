
""" dein init

set runtimepath+=~/.dotfiles/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.dotfiles/nvim/dein')
  call dein#begin('~/.dotfiles/nvim/dein')
  call dein#add('~/.dotfiles/nvim/dein/repos/github.com/Shougo/dein.vim')

  " navigation
  call dein#add('preservim/nerdtree')
  call dein#add('majutsushi/tagbar')
  call dein#add('christoomey/vim-tmux-navigator')
  " code completion
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-jedi')
  call dein#add('davidhalter/jedi-vim')
  " vim-airline
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  " code style
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('sbdchd/neoformat')
  " code checker
  call dein#add('neomake/neomake')
  " color schemes
  call dein#add('joshdick/onedark.vim')
  call dein#add('gilgigilgil/anderson.vim')
  call dein#add('wadackel/vim-dogrun')
  " git diff & merge
  call dein#add('tpope/vim-fugitive')
  
  call dein#end()
  call dein#save_state()
endif

""" custom
"""""""""""""""""

" use , as leader
let mapleader = ","
let g:mapleader = ","

" turn hybrid line numbers on
set number relativenumber
set nu rnu
" smart tab with spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
" <esc> clears visual selection
nnoremap <esc> :noh<return><esc>
" enable mouse
set mouse=a
" use system clipboard
set clipboard+=unnamedplus
" spell check
" set spell
" exec macro q with space
nnoremap <Space> @q

" remove with x-d-D
nnoremap x "_x
nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
" cut with <leader> x-d-D
nnoremap <leader>x ""x
vnoremap <leader>x ""x
nnoremap <leader>d ""d
vnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>D ""D
nnoremap <leader>dd ""dd
vnoremap p ""p
nnoremap p ""p

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>

" tabgar
nmap <C-t> :TagbarToggle<CR>

" deoplete
let g:deoplete#enable_at_startup = 1
let g:python3_host_prog = $HOME.'/.pyenv/shims/python'
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" airline
let g:airline_theme='dark_minimal'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0

" neoformat 
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1

" neomake
" let g:neomake_python_enabled_makers = ['pylint']
" call neomake#configure#automake('nrwi', 500)

" onedark
colorscheme dogrun

" vim-tmux-navigator config
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
" pane creation using SHIFT-./,
nnoremap <M-.> :vsp<return><esc>
nnoremap <M-,> :sp<return><esc>


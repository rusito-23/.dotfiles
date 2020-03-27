
""" Setup Dein

set runtimepath+=~/.dotfiles/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.dotfiles/nvim/dein')
  call dein#begin('~/.dotfiles/nvim/dein')
  call dein#add('~/.dotfiles/nvim/dein/repos/github.com/Shougo/dein.vim')

  " navigation
  call dein#add('preservim/nerdtree')
  call dein#add('majutsushi/tagbar')
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
  " colorschemes
  call dein#add('joshdick/onedark.vim')
  
  call dein#end()
  call dein#save_state()
endif

""" Custom Config
"""""""""""""""""

" native
set relativenumber
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
nnoremap <esc> :noh<return><esc>

" pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <S-J> :vsp<return><esc>
nnoremap <S-K> :sp<return><esc>

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>

" tabgar
nmap <C-t> :TagbarToggle<CR>

" deoplete
let g:deoplete#enable_at_startup = 1
let g:python3_host_prog = '/Users/igor/.pyenv/shims/python'
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
let g:neomake_python_enabled_makers = ['pylint']
call neomake#configure#automake('nrwi', 500)

" onedark
colorscheme onedark

""""""""""""""""""""""""""""""
" misc

" leader
let mapleader = ","
let g:mapleader = ","

" numbers
set number relativenumber
set nu rnu

" tabs 
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" indent 
filetype on
filetype plugin on
filetype indent on
set autoindent

" enable mouse 
set mouse=a

" scroll offset 
set scrolloff=3

" syntax 
syntax on

" show wrapping at col 80
" set colorcolumn=80  

" remove default mode indicator
set noshowmode

""""""""""""""""""""""""""""""
" exec macro q with space
nnoremap <Space> @q

" don't drop the macro exeq
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

""""""""""""""""""""""""""""""
" clear all buffers

nnoremap <leader>ca :w <bar> %bd <bar> e# <bar> bd# <CR><CR>

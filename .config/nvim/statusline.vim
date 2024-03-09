" ███████╗████████╗ █████╗ ████████╗██╗   ██╗███████╗  ██╗   ██╗██╗███╗   ███╗
" ██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝██║   ██║██╔════╝  ██║   ██║██║████╗ ████║
" ███████╗   ██║   ███████║   ██║   ██║   ██║███████╗  ██║   ██║██║██╔████╔██║
" ╚════██║   ██║   ██╔══██║   ██║   ██║   ██║╚════██║  ╚██╗ ██╔╝██║██║╚██╔╝██║
" ███████║   ██║   ██║  ██║   ██║   ╚██████╔╝███████║██╗╚████╔╝ ██║██║ ╚═╝ ██║
" ╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚══════╝╚═╝ ╚═══╝  ╚═╝╚═╝     ╚═╝
"
" Author: Igor Andruskiewitsch
" License: MIT
" Notes:
"    My Neovim status line configuration
"    Needs a Power line Font to display the separators
"    Supports these plugins:
"    Nerd Tree: Basic status line with buffer number
"    Fugitive: Basic status line indicating the description

" {{{ Main Status Line Builder

function statusline#build(bufnr, focused)
    " Get buffer name
    let l:bufname = bufname(a:bufnr)

    " Nerd Tree status line
    if l:bufname =~ 'Nerd_tree'
        call statusline#build_nerdtree(a:focused)
        return
    endif

    " Fugitive status line
    if l:bufname =~ 'fugitive'
        call statusline#build_fugitive(l:bufname, a:focused)
        return
    endif

    " Default status line
    call statusline#build_default(a:focused)
endfunction

" }}}

" {{{ Default Status Line Builder

" {{{ Mode Names

let mode_names = {
    \"n":        "NORMAL",
    \"no":       "N·OP",
    \"v":        "VISUAL",
    \"V":        "V·LINE",
    \"\<C-v>":   "V·BLOCK",
    \"s":        "SELECT",
    \"S":        "S·LINE",
    \"\<C-s>":   "S·BLOCK",
    \"i":        "INSERT",
    \"ic":       "INSERT",
    \"ix":       "INSERT",
    \"R":        "REPLACE",
    \"Rv":       "V·REPLACE",
    \"c":        "COMMAND",
    \"cv":       "VIM EX",
    \"ce":       "EX",
    \"r":        "PROMPT",
    \"rm":       "MORE",
    \"r?":       "CONFIRM",
    \"!":        "SHELL",
    \"t":        "TERMINAL",
\}

" }}}

" {{{

function! statusline#get_encoding() abort
    return (&fenc != "" ? &fenc : &enc)
endfunction

" }}}

function! statusline#build_default(focused) abort
    if a:focused
        call statusline#build_default_focused()
    else
        call statusline#build_default_defocused()
    endif
endfunction

function! statusline#build_default_focused() abort
    setlocal statusline=
    setlocal statusline+=%#Primary#                         " Use primary color
    setlocal statusline+=\ %{toupper(mode_names[mode()])}\  " The current mode
    setlocal statusline+=%#PrimarySep#                     " Separator
    setlocal statusline+=%#Secondary#                       " Use secondary color
    setlocal statusline+=\ %Y\                              " File type
    setlocal statusline+=%#Secondary#                      " Separator
    setlocal statusline+=%#Tertiary#                        " Use secondary color
    setlocal statusline+=\ %<%f%m%r%h%w\                    " File info
    setlocal statusline+=%#Secondary#                      " Separator
    setlocal statusline+=%=                                 " Center
    setlocal statusline+=%#Secondary#                      " Separator
    setlocal statusline+=%#Tertiary#                        " Use tertiary color
    setlocal statusline+=\ C:%02v                           " Column
    setlocal statusline+=\ L:%02l/%02L\                     " Line number
    setlocal statusline+=%#Secondary#                      " Separator
    setlocal statusline+=%#Tertiary#                        " Use tertiary color
    setlocal statusline+=\ %3p%%\                           " Doc percentage
    setlocal statusline+=%#Secondary#                      " Separator
    setlocal statusline+=\ %\{statusline#get_encoding()}\               " Encoding
    setlocal statusline+=%#PrimarySep#                     " Separator
    setlocal statusline+=%#Primary#                         " Use primary color
    setlocal statusline+=\ B%n\                             " Buffer number
    setlocal statusline+=%#Clear#                           " Clear colors
endfunction

function! statusline#build_default_defocused() abort
    setlocal statusline=
    setlocal statusline+=%#Secondary#     " Use secondary color
    setlocal statusline+=\ %Y\            " File type
    setlocal statusline+=%#Secondary#    " Separator
    setlocal statusline+=%#Tertiary#      " Use secondary color
    setlocal statusline+=\ %<%f%m%r%h%w\  " File info
    setlocal statusline+=%#Secondary#    " Separator
    setlocal statusline+=%=               " Center
    setlocal statusline+=%#Secondary#     " Use secondary color
    setlocal statusline+=                " Separator
    setlocal statusline+=\ B%n\           " Buffer number
    setlocal statusline+=%#Clear#         " Clear colors
endfunction

" }}}

" {{{ Nerd Tree Status Line Builder

function! statusline#build_nerdtree(focused) abort
    if a:focused
        call statusline#build_nerdtree_focused()
    else
        call statusline#build_nerdtree_defocused()
    endif
endfunction

function! statusline#build_nerdtree_focused() abort
    setlocal statusline=
    setlocal statusline+=%#Primary#      " Use primary color
    setlocal statusline+=\ %Y\           " File type
    setlocal statusline+=%#PrimarySep#  " Separator
    setlocal statusline+=%=              " Center
    setlocal statusline+=%#PrimarySep#  " Separator
    setlocal statusline+=%#Primary#      " Use main color
    setlocal statusline+=\ B%n\          " Buffer number
    setlocal statusline+=%#Clear#        " Clear colors
endfunction

function! statusline#build_nerdtree_defocused() abort
    setlocal statusline=
    setlocal statusline+=%#Secondary#  " Use secondary color
    setlocal statusline+=\ %Y\         " File type
    setlocal statusline+=             " Separator
    setlocal statusline+=%=            " Center
    setlocal statusline+=             " Separator
    setlocal statusline+=\ B%n\        " Buffer number
    setlocal statusline+=%#Clear#      " Clear colors
endfunction

" }}}

" {{{ Fugitive Status Line Builders

function! statusline#build_fugitive(bufname, focused) abort
    " Parse buffer description
    let l:bufdesc = ''
    if a:bufname =~ '\/\/2'
        " The left side of the merge
        let l:bufdesc .= '\ MERGE\ BASE\ '
    elseif a:bufname =~ '\/\/3'
        " The right side of the merge
        let l:bufdesc .= '\ MERGE\ TARGET\ '
    elseif a:bufname =~ '\/\/0'
        " The left side of the diff
        let l:bufdesc .= '\ DIFF\ BASE\ '
    endif

    " Build fugitive status line
    if a:focused
        call statusline#build_fugitive_focused(l:bufdesc)
    else
        call statusline#build_fugitive_defocused(l:bufdesc)
    endif
endfunction

function! statusline#build_fugitive_focused(bufdesc) abort
    setlocal statusline=
    setlocal statusline+=%#Primary#      " Use primary color
    exec 'setlocal statusline+='.a:bufdesc
    setlocal statusline+=%#PrimarySep#  " Separator
    setlocal statusline+=%=              " Center
    setlocal statusline+=%#PrimarySep#  " Separator
    setlocal statusline+=%#Primary#      " Use main color
    setlocal statusline+=\ B%n\          " Buffer number
    setlocal statusline+=%#Clear#        " Clear colors
endfunction

function! statusline#build_fugitive_defocused(bufdesc) abort
    setlocal statusline=
    setlocal statusline+=%#Secondary#  " Use secondary color
    exec 'setlocal statusline+='.a:bufdesc
    setlocal statusline+=             " Separator
    setlocal statusline+=%=            " Center
    setlocal statusline+=             " Separator
    setlocal statusline+=\ B%n\        " Buffer number
    setlocal statusline+=%#Clear#      " Clear colors
endfunction

" }}}

" {{{ Auto-command Group

" Build the Status Line based on buffer movements
augroup BuildStatusLine
    autocmd!
    autocmd BufEnter,WinEnter * call statusline#build(bufnr(), 1)
    autocmd BufLeave,WinLeave * call statusline#build(bufnr(), 0)
augroup end

" }}}

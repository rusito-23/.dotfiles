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
" My Neovim status line configuration
" Needs a Powerline Font to display the separators

" {{{ Main Status Line Builder

function BuildStatusLine(bufnr, active)
    " Hide status line if there's any fugitive file in the current tab
    for bufnr in tabpagebuflist(tabpagenr())
        if bufname(bufnr) =~ 'fugitive'
            set laststatus=0
            return
        endif
    endfor

    " Special Nerd Tree status line
    if bufname(a:bufnr) =~ 'Nerd_tree'
        if a:active
            setlocal statusline=%!BuildActiveNerdTreeStatusLine()
        else
            setlocal statusline=%!BuildInactiveNerdTreeStatusLine()
        endif
        set laststatus=2
        return
    endif

    " Special fugitive status line

    " Build default status line
    if a:active
        setlocal statusline=%!BuildActiveStatusLine()
    else
        setlocal statusline=%!BuildInactiveStatusLine()
    endif

    " Show the status line by default
    set laststatus=2
endfunction

" }}}

" {{{ Active Status Line Builder

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

function! BuildActiveStatusLine() abort
    let l:status_line = ''
    let l:status_line .= '%#Primary#'                         " Use primary color
    let l:status_line .= ' %{toupper(mode_names[mode()])} '   " The current mode
    let l:status_line .= '%#PrimarySep#'                     " Separator
    let l:status_line .= '%#Secondary#'                       " Use secondary color
    let l:status_line .= ' %Y '                               " File type
    let l:status_line .= '%#Secondary#'                      " Separator
    let l:status_line .= '%#Tertiary#'                        " Use secondary color
    let l:status_line .= ' %<%F%m%r%h%w '                     " File info
    let l:status_line .= '%#Secondary#'                      " Separator
    let l:status_line .= '%='                                 " Center
    let l:status_line .= '%#Secondary#'                      " Separator
    let l:status_line .= '%#Tertiary#'                        " Use tertiary color
    let l:status_line .= ' C:%02v'                            " Column
    let l:status_line .= ' L:%02l/%02L '                      " Line number
    let l:status_line .= '%#Secondary#'                      " Separator
    let l:status_line .= '%#Tertiary#'                        " Use tertiary color
    let l:status_line .= ' %3p%% '                            " Doc percentage
    let l:status_line .= '%#Secondary#'                      " Separator
    let l:status_line .= ' %{"".(&fenc!=""?&fenc:&enc).""} '  " Encoding
    let l:status_line .= '%#PrimarySep#'                     " Separator
    let l:status_line .= '%#Primary#'                         " Use primary color
    let l:status_line .= ' B%n '                              " Buffer number
    let l:status_line .= '%#Clear#'                           " Clear colors
    return l:status_line
endfunction

" }}}

" {{{ Inactive Status Line Builder

function! BuildInactiveStatusLine() abort
    let l:status_line = ''
    let l:status_line .= '%#Secondary#'    " Use secondary color
    let l:status_line .= ' %Y '            " File type
    let l:status_line .= '%#Secondary#'   " Separator
    let l:status_line .= '%#Tertiary#'     " Use secondary color
    let l:status_line .= ' %<%F%m%r%h%w '  " File info
    let l:status_line .= '%#Secondary#'   " Separator
    let l:status_line .= '%='              " Center
    let l:status_line .= '%#Secondary#'    " Use secondary color
    let l:status_line .= ''               " Separator
    let l:status_line .= ' B%n '           " Buffer number
    let l:status_line .= '%#Clear#'        " Clear colors
    return l:status_line
endfunction

" }}}

" {{{ Nerd Tree Status Line Builders

function! BuildActiveNerdTreeStatusLine() abort
    let l:status_line = ''
    let l:status_line .= '%#Primary#'      " Use primary color
    let l:status_line .= ' %Y '            " File type
    let l:status_line .= '%#PrimarySep#'  " Separator
    let l:status_line .= '%='              " Center
    let l:status_line .= '%#PrimarySep#'  " Separator
    let l:status_line .= '%#Primary#'      " Use main color
    let l:status_line .= ' B%n '           " Buffer number
    let l:status_line .= '%#Clear#'        " Clear colors
    return l:status_line
endfunction

function! BuildInactiveNerdTreeStatusLine() abort
    let l:status_line = ''
    let l:status_line .= '%#Secondary#'  " Use secondary color
    let l:status_line .= ' %Y '          " File type
    let l:status_line .= ''             " Separator
    let l:status_line .= '%='            " Center
    let l:status_line .= ''             " Separator
    let l:status_line .= ' B%n '         " Buffer number
    let l:status_line .= '%#Clear#'      " Clear colors
    return l:status_line
endfunction

" }}}

" {{{ Auto-command Group

" Status line builder
augroup BuildStatusLine
    autocmd!
    autocmd BufEnter,WinEnter * call BuildStatusLine(bufnr(), 1)
    autocmd BufLeave,WinLeave * call BuildStatusLine(bufnr(), 0)
augroup end

" }}}

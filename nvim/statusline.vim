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
" Uses Powerlevel Fonts to display the separators

" Set status line builder
" set statusline=%!BuildStatusLine()

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

" {{{ Active Status Line Builder

function! BuildActiveStatusLine() abort
    let l:status_line = ''
    let l:status_line .= '%#Primary#'                               " Use primary color
    let l:status_line .= ' %{toupper(mode_names[mode()])} '         " The current mode
    let l:status_line .= '%#PrimarySep#'                           " Separator
    let l:status_line .= '%#Secondary#'                             " Use secondary color
    let l:status_line .= ' %Y '                                     " File type
    let l:status_line .= '%#Secondary#'                            " Separator
    let l:status_line .= '%#Tertiary#'                              " Use secondary color
    let l:status_line .= ' %<%F%m%r%h%w '                           " File path, modified, readonly, helpfile, preview
    let l:status_line .= '%#Secondary#'                            " Separator
    let l:status_line .= '%='                                       " Center
    let l:status_line .= '%#Secondary#'                            " Separator
    let l:status_line .= '%#Tertiary#'                              " Use tertiary color
    let l:status_line .= ' C:%02v'                                  " Column
    let l:status_line .= ' L:%02l/%02L '                            " Line number
    let l:status_line .= '%#Secondary#'                            " Separator
    let l:status_line .= '%#Tertiary#'                              " Use tertiary color
    let l:status_line .= ' %3p%% '                                  " Doc percentage
    let l:status_line .= '%#Secondary#'                            " Separator
    let l:status_line .= ' %{"".(&fenc!=""?&fenc:&enc).""} '        " Encoding
    let l:status_line .= '%#PrimarySep#'                           " Separator
    let l:status_line .= '%#Primary#'                               " Use primary color
    let l:status_line .= ' B%n '                                    " Buffer number
    let l:status_line .= '%#Clear#'                                 " Clear colors
    return l:status_line
endfunction

" }}}

" {{{ Active Status Line Builder

function! BuildInactiveStatusLine() abort
    let l:status_line = ''
    let l:status_line .= '%#Secondary#'                             " Use secondary color
    let l:status_line .= ' %Y '                                     " File type
    let l:status_line .= '%#Secondary#'                            " Separator
    let l:status_line .= '%#Tertiary#'                              " Use secondary color
    let l:status_line .= ' %<%F%m%r%h%w '                           " File path, modified, readonly, helpfile, preview
    let l:status_line .= '%#Secondary#'                            " Separator
    let l:status_line .= '%='                                       " Center
    let l:status_line .= '%#Secondary#'                             " Use secondary color
    let l:status_line .= ''                                        " Separator
    let l:status_line .= ' B%n '                                    " Buffer number
    let l:status_line .= '%#Clear#'                                 " Clear colors
    return l:status_line
endfunction

" }}}

" {{{ Auto-command Group

augroup StatusLineHelper
    autocmd!
    autocmd BufEnter,WinEnter * setlocal statusline=%!BuildActiveStatusLine()
    autocmd BufLeave,WinLeave * setlocal statusline=%!BuildInactiveStatusLine()
augroup end

" }}}

" ███████╗████████╗ █████╗ ████████╗██╗   ██╗███████╗  ██╗   ██╗██╗███╗   ███╗
" ██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝██║   ██║██╔════╝  ██║   ██║██║████╗ ████║
" ███████╗   ██║   ███████║   ██║   ██║   ██║███████╗  ██║   ██║██║██╔████╔██║
" ╚════██║   ██║   ██╔══██║   ██║   ██║   ██║╚════██║  ╚██╗ ██╔╝██║██║╚██╔╝██║
" ███████║   ██║   ██║  ██║   ██║   ╚██████╔╝███████║██╗╚████╔╝ ██║██║ ╚═╝ ██║
" ╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚══════╝╚═╝ ╚═══╝  ╚═╝╚═╝     ╚═╝
"
" Author: Igor Andruskiewitsch
" License: MIT
" Notes: My Neovim status line configuration

" {{{ Mode Names

let mode_names = {
    \'n':        'NORMAL',
    \'no':       'N·Operator Pending',
    \'v':        'VISUAL',
    \'V':        'V·Line',
    \'^V':       'V·Block',
    \'s':        'Select',
    \'S':        'S·Line',
    \'^S':       'S·Block',
    \'i':        'INSERT',
    \'ic':       'INSERT',
    \'ix':       'INSERT',
    \'R':        'Replace',
    \'Rv':       'V·Replace',
    \'c':        'COMMAND',
    \'cv':       'Vim Ex',
    \'ce':       'Ex',
    \'r':        'Prompt',
    \'rm':       'More',
    \'r?':       'Confirm',
    \'!':        'Shell',
    \'t':        'TERMINAL',
\}

" }}}

" {{{ Status line

set statusline=
set statusline+=%0*                                     " Color 0
set statusline+=\ %{toupper(mode_names[mode()])}\       " The current mode
set statusline+=%1*%4*                                 " Separator
set statusline+=\ %Y\                                   " File type
set statusline+=%3*%2*                                 " Separator
set statusline+=\ %<%F%m%r%h%w\                         " File path, modified, readonly, helpfile, preview
set statusline+=%1*                                    " Separator
set statusline+=%=                                      " Right Side
set statusline+=%1*%2*                                 " Separator
set statusline+=\ %02v:%02l\                            " Column and line numbers
set statusline+=%1*%2*                                 " Separator
set statusline+=\ %3p%%\                                " Doc percentage
set statusline+=%1*                                    " Separator
set statusline+=\ %{''.(&fenc!=''?&fenc:&enc).''}\      " Encoding
set statusline+=%1*%0*                                 " Separator
set statusline+=\ B%n\                                  " Buffer number

" }}}

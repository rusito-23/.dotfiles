" ██████╗ ██████╗ ██╗      ██████╗ ██████╗ ███████╗  ██╗   ██╗██╗███╗   ███╗
"██╔════╝██╔═══██╗██║     ██╔═══██╗██╔══██╗██╔════╝  ██║   ██║██║████╗ ████║
"██║     ██║   ██║██║     ██║   ██║██████╔╝███████╗  ██║   ██║██║██╔████╔██║
"██║     ██║   ██║██║     ██║   ██║██╔══██╗╚════██║  ╚██╗ ██╔╝██║██║╚██╔╝██║
"╚██████╗╚██████╔╝███████╗╚██████╔╝██║  ██║███████║██╗╚████╔╝ ██║██║ ╚═╝ ██║
" ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝ ╚═══╝  ╚═╝╚═╝     ╚═╝
"
" Author: Igor Andruskiewitsch
" License: MIT
" Notes: Color definitions

" Spellchecker colors
hi SpellBad     cterm=underline   ctermfg=red
hi SpellCap     cterm=underline   ctermfg=yellow
hi SpellLocal   cterm=underline   ctermfg=yellow

" Color scheme
set termguicolors
colorscheme nord

" Vim-Fugitive Special Colors
hi DiffAdd      gui=NONE   guifg=green   guibg=NONE
hi DiffDelete   gui=NONE   guifg=red     guibg=NONE
hi DiffChange   gui=NONE   guifg=yellow  guibg=NONE

" Status line colors
hi statusline     ctermfg=black   ctermbg=cyan    guifg=black     guibg=#8fbfdc
hi User1          ctermfg=cyan    ctermbg=239     guifg=#8fbfdc   guibg=#4e4e4e
hi User2          ctermfg=007     ctermbg=239     guifg=#cdcdcd   guibg=#4e4e4e
hi User3          ctermfg=cyan    ctermbg=239     guifg=#8fbfdc   guibg=#4e4e4e
hi User4          ctermfg=007     ctermbg=239     guifg=#adadad   guibg=#4e4e4e

" Tab bar colors
hi TabLineSel     ctermfg=black   ctermbg=cyan    guifg=black     guibg=#8fbfdc
hi TabLine        ctermfg=cyan    ctermbg=239     guifg=#8fbfdc   guibg=#4e4e4e
hi TabLineSelSep  ctermfg=cyan    ctermbg=239     guifg=#8fbfdc   guibg=#4e4e4e
hi TabLineSep     ctermfg=cyan    ctermbg=239     guifg=#8fbfdc   guibg=#4e4e4e
hi TabLineSepAlt  ctermfg=239     ctermbg=cyan    guifg=#4e4e4e   guibg=#8fbfdc
hi TabLineFill    ctermfg=007     ctermbg=239     guifg=#cdcdcd   guibg=#4e4e4e

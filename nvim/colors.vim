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
hi DiffAdd     ctermfg=Green     ctermbg=None     guifg=Green     guibg=None     gui=None       cterm=None
hi DiffDelete  ctermfg=DarkRed   ctermbg=None     guifg=DarkRed   guibg=None     gui=Bold       cterm=Bold
hi DiffChange  ctermfg=DarkCyan  ctermbg=None     guifg=DarkCyan  guibg=None     gui=None       cterm=None
hi DiffText    ctermfg=Green     ctermbg=None     guifg=Green     guibg=None     gui=Underline  cterm=Underline

" Line Colors
hi Primary        ctermfg=black  ctermbg=cyan  guifg=black    guibg=#8fbfdc  gui=None  cterm=None
hi PrimaryBold    ctermfg=black  ctermbg=cyan  guifg=black    guibg=#8fbfdc  gui=Bold  cterm=Bold
hi PrimarySep     ctermfg=cyan   ctermbg=239   guifg=#8fbfdc  guibg=#4e4e4e  gui=None  cterm=None
hi Secondary      ctermfg=cyan   ctermbg=239   guifg=#8fbfdc  guibg=#4e4e4e  gui=None  cterm=None
hi SecondaryBold  ctermfg=cyan   ctermbg=239   guifg=#8fbfdc  guibg=#4e4e4e  gui=Bold  cterm=Bold
hi SecondarySep   ctermfg=239    ctermbg=cyan  guifg=#4e4e4e  guibg=#8fbfdc  gui=None  cterm=None
hi Tertiary       ctermfg=007    ctermbg=239   guifg=#adadad  guibg=#4e4e4e  gui=None  cterm=None
hi TertiaryBold   ctermfg=007    ctermbg=239   guifg=#adadad  guibg=#4e4e4e  gui=Bold  cterm=Bold
hi TertiarySep    ctermfg=239    ctermbg=cyan  guifg=#4e4e4e  guibg=#8fbfdc  gui=None  cterm=None
hi Clear          ctermfg=None   ctermbg=None  guifg=None     guibg=None     gui=None  cterm=None

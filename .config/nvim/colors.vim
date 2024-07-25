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
let g:onedark_config = {
    \ 'style': 'warm',
\}
colorscheme onedark

" Git Colors
" Used when using vim as diff or merge tool
hi DiffAdd     ctermfg=White  ctermbg=Green    guifg=White  guibg=Green    gui=None       cterm=None
hi DiffDelete  ctermfg=White  ctermbg=DarkRed  guifg=White  guibg=DarkRed  gui=Bold       cterm=Bold
hi DiffChange  ctermfg=White  ctermbg=Gray     guifg=White  guibg=Gray     gui=None       cterm=None
hi DiffText    ctermfg=White  ctermbg=Green    guifg=White  guibg=Green    gui=Underline  cterm=Underline

" Line Colors
" Used for the tab and status lines
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

" Clear Tex Highlights
augroup ClearTextHighlights
    autocmd FileType tex
                \ hi clear texItalBoldStyle |
                \ hi clear texItalStyle |
                \ hi clear texBoldStyle |
                \ hi clear texEmphStyle
augroup end

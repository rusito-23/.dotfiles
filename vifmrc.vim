" vim: filetype=vifm :
" ██╗   ██╗██╗███████╗███╗   ███╗██████╗  ██████╗
" ██║   ██║██║██╔════╝████╗ ████║██╔══██╗██╔════╝
" ██║   ██║██║█████╗  ██╔████╔██║██████╔╝██║
" ╚██╗ ██╔╝██║██╔══╝  ██║╚██╔╝██║██╔══██╗██║
"  ╚████╔╝ ██║██║     ██║ ╚═╝ ██║██║  ██║╚██████╗
"   ╚═══╝  ╚═╝╚═╝     ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝


" {{{ General configs

set vicmd=vim
set syscalls                    " vifm file operations
set trash                       " don't delete - move to trash
set history=100                 " dirs to store in the history
set nofollowlinks               " automatically resolve sylinks on l or Enter.
set fastrun                     " run partially entered commands (e.g. :!Te instead of :!Terminal or :!Te<tab>).
set sortnumbers                 " natural sort of (version) numbers
set undolevels=100              " maximum number of changes that can be undone.
set vimhelp                     " cool helpfile
set runexec                     " run executables with Enter
set timefmt=%m/%d\ %H:%M        " time format
set scrolloff=4                 " scroll offset
set slowfs=curlftpfs            " prevent slow file system

" search configs (cool completion)
set wildmenu
set wildstyle=popup
set suggestoptions=normal,visual,view,otherpane,keys,marks,registers
set ignorecase
set smartcase
set nohlsearch
set incsearch

" cool color scheme
colorscheme zenburn

" }}}

" {{{ cool statusline

" colors
highlight User1      ctermbg=232          ctermfg=186        cterm=none
highlight User2      ctermbg=236          ctermfg=232        cterm=none
highlight User3      ctermbg=236          ctermfg=white      cterm=none
highlight User4      ctermbg=238          ctermfg=236        cterm=none
highlight User5      ctermbg=238          ctermfg=108        cterm=none
highlight User6      ctermbg=239          ctermfg=189        cterm=none

" segments
let $CUR_FILE_SZ="%1* %E %2*"          " current file
let $CUR_FILE="%3* %t %4*"             " current file size
let $CUR_FILE_LN="%5* %T %4*"          " current file link
let $SEPARATOR="%="                     " middle separator
let $MOD_DATE="%5* %d "                " current file size
let $PERMS="%4*%3* %A "                " perms
let $USER="%2*%1* %u @ %g"             " user @ group

" statusline
execute 'set' 'statusline="'
    \ . $CUR_FILE_SZ
    \ . $CUR_FILE
    \ . $CUR_FILE_LN
    \ . $SEPARATOR
    \ . $MOD_DATE
    \ . $PERMS
    \ . $USER
    \ .'"'

" }}}

" {{{ Marks

mark h ~/
mark r ~/repos

" }}}

" {{{ Commands

command! diff nvim -d %f %F
command! zip zip -r %f.zip %f
command! run !! ./%f
command! make !!make %a
command! mkcd :mkdir %a | cd %a
command! src :source ~/.config/vifm/vifmrc

" }}}

" {{{ Previews and Viewers

" pdf
filetype *.pdf
        \ open,
fileviewer *.pdf pdftotext -nopgbrk %c -

" audio
filetype *.wav,*.mp3,*.flac,*.m4a,*.wma,*.ape,*.ac3,*.og[agx],*.spx,*.opus
        \ open,
fileviewer *.mp3 mp3info
fileviewer *.flac soxi

" video
filetype *.avi,*.mp4,*.wmv,*.dat,*.3gp,*.ogv,*.mkv,*.mpg,*.mpeg,*.vob,
        \*.fl[icv],*.m2v,*.mov,*.webm,*.ts,*.mts,*.m4v,*.r[am],*.qt,*.divx,
        \*.as[fx]
        \ open,
fileviewer *.avi,*.mp4,*.wmv,*.dat,*.3gp,*.ogv,*.mkv,*.mpg,*.mpeg,*.vob,
        \*.fl[icv],*.m2v,*.mov,*.webm,*.ts,*.mts,*.m4v,*.r[am],*.qt,*.divx,
        \*.as[fx]
        \ ffprobe -pretty %c 2>&1

" object
filetype *.o nm %f | less

" man page
filetype *.[1-8] man ./%c
fileviewer *.[1-8] man ./%c | col -b

" image
filetype *.bmp,*.jpg,*.jpeg,*.png,*.gif,*.xpm,
        \ open,
fileviewer *.bmp,*.jpg,*.jpeg,*.png,*.gif,*.xpm,
        \ identify %c

" md5
filetype *.md5
        \ md5sum -c %f %S,

" sha1
filetype *.sha1
        \ sha1sum -c %f %S,

" sha256
filetype *.sha256
        \ sha256sum -c %f %S,

" sha512
filetype *.sha512
        \ sha512sum -c %f %S,

" syntax highlighting in preview
fileviewer *[^/]
        \ env -uCOLORTERM bat --color always --wrap never --pager never %c -p

" default command
filetype *[^/] nvim

" }}}

" {{{ Sessions persistence

set vifminfo=dhistory,savedirs,chistory,state,tui,shistory,
    \phistory,fhistory,dirstack,registers,bookmarks,bmarks

" }}}

" {{{ Mappings

" toggle preview visibility
nnoremap w :view<cr>
vnoremap w :view<cr>gv

" yank current directory path into the clipboard
nnoremap yd :!printf %d | pbcopy<cr>

" yank current file path into the clipboard
nnoremap yf :!printf %c:p | pbcopy<cr>

" preview current image
nnoremap ,p :!!shellpic --shell24 %c<cr>

" new tmux window in cur dir
nnoremap ,n :!tmux new-window -c %d<cr>

" new vertical tmux pane and open in nvim
nnoremap ,o :!tmux split-window -h -c %d "nvim %c"<cr>

" new tmux win and open in nvim
nnoremap ,ow :!tmux new-window -c %d "nvim %c"<cr>

" }}}

" {{{ fzf integration
" https://wiki.vifm.info/index.php/How_to_integrate_fzf_for_fuzzy_finding

command! FZFgoto :set noquickview | :execute 'goto' fnameescape(term('fzf --no-height 2>/dev/tty'))
nnoremap ,e :FZFgoto<cr>

" }}}

" vim: filetype=vifm :

" ------------------------------------------------------------------------------
" General configs

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

" cool status line
set statusline="TODO"

" ------------------------------------------------------------------------------
" Marks

mark h ~/

" ------------------------------------------------------------------------------
" Commands

command! diff diff %f %F
command! zip zip -r %f.zip %f
command! run !! ./%f
command! make !!make %a
command! mkcd :mkdir %a | cd %a
command! reload :source ~/.config/vifm/vifmrc

" ------------------------------------------------------------------------------
" Previews and Viewers

" Pdf
filetype *.pdf
        \ {Open in Preview}
        \ open -a Preview.app,
fileviewer *.pdf pdftotext -nopgbrk %c -

" PostScript
filetype *.ps,*.eps open -a Preview.app

" Audio
filetype *.wav,*.mp3,*.flac,*.m4a,*.wma,*.ape,*.ac3,*.og[agx],*.spx,*.opus
        \ {Open in iTunes}
        \ open -a iTunes.app,
        \ {Open in QuickTime Player}
        \ open -a QuickTime\ Player.app,
fileviewer *.mp3 mp3info
fileviewer *.flac soxi

" Video
filetype *.avi,*.mp4,*.wmv,*.dat,*.3gp,*.ogv,*.mkv,*.mpg,*.mpeg,*.vob,
        \*.fl[icv],*.m2v,*.mov,*.webm,*.ts,*.mts,*.m4v,*.r[am],*.qt,*.divx,
        \*.as[fx]
        \ {Open in QuickTime Player}
        \ open -a QuickTime\ Player.app,
fileviewer *.avi,*.mp4,*.wmv,*.dat,*.3gp,*.ogv,*.mkv,*.mpg,*.mpeg,*.vob,
        \*.fl[icv],*.m2v,*.mov,*.webm,*.ts,*.mts,*.m4v,*.r[am],*.qt,*.divx,
        \*.as[fx]
        \ ffprobe -pretty %c 2>&1

" Web
filetype *.html,*.htm
        \ {Open in vim}
        \ vim,
fileviewer *.html,*.htm w3m -dump -T text/html

" Object
filetype *.o nm %f | less

" Man page
filetype *.[1-8] man ./%c
fileviewer *.[1-8] man ./%c | col -b

" Image
filetype *.bmp,*.jpg,*.jpeg,*.png,*.gif,*.xpm,
        \ open -a Preview.app,
fileviewer *.png
        \ env -uCOLORTERM shellpic %c

" MD5
filetype *.md5
        \ {Check MD5 hash sum}
        \ md5sum -c %f %S,

" SHA1
filetype *.sha1
        \ {Check SHA1 hash sum}
        \ sha1sum -c %f %S,

" SHA256
filetype *.sha256
        \ {Check SHA256 hash sum}
        \ sha256sum -c %f %S,

" SHA512
filetype *.sha512
        \ {Check SHA512 hash sum}
        \ sha512sum -c %f %S,

" syntax highlighting in preview
fileviewer *[^/]
        \ env -uCOLORTERM bat --color always --wrap never --pager never %c -p

" open every other file with default
filetype * open

" ------------------------------------------------------------------------------
" Sessions persistence

set vifminfo=dhistory,savedirs,chistory,state,tui,shistory,
    \phistory,fhistory,dirstack,registers,bookmarks,bmarks

" ------------------------------------------------------------------------------
" Mappings

" start shell in current directory
nnoremap s :shell<cr>

" display sorting dialog
nnoremap S :sort<cr>

" toggle visibility of preview window
nnoremap w :view<cr>
vnoremap w :view<cr>gv

" yank current directory path into the clipboard
nnoremap yd :!printf %d | pbcopy<cr>

" yank current file path into the clipboard
nnoremap yf :!printf %c:p | pbcopy<cr>

" mappings for faster renaming
nnoremap I cw<c-a>
nnoremap cc cw<c-u>
nnoremap A cw

" toggle wrap setting on ,w key
nnoremap ,w :set wrap!<cr>

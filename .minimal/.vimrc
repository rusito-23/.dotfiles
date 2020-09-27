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

" clear 
nnoremap <leader><space> :noh<return><esc>

" mouse 
set mouse=a

" scroll offset 
set scrolloff=3

" fuzzy find 
set wildmenu
set path+=**

" syntax 
syntax on

" colorscheme
colorscheme desert

" insert mode cursor 
let &t_EI = "\033[1 q"  " normal cursor (block)
let &t_SI = "\033[6 q"  " insert cursor (vertical bar)
let &t_SR = "\033[4 q"  " replace cursor (underscore)

""""""""""""""""""""""""""""""
" macros

" exec macro q with space
nnoremap <Space> @q

""""""""""""""""""""""""""""""
" clear all buffers

nnoremap <leader>ca :w <bar> %bd <bar> e# <bar> bd# <CR><CR>

""""""""""""""""""""""""""""""
" statusline

hi Green        ctermfg=Green   ctermbg=none    term=bold cterm=bold
hi Cyan         ctermfg=Cyan    ctermbg=none    term=none cterm=none
hi Grey         ctermfg=Grey    ctermbg=none    term=none cterm=none
hi Magenta      ctermfg=Magenta ctermbg=none    term=none cterm=none

set laststatus=2
set statusline=
set statusline +=%#Green#                               " mode color
set statusline +=\ %{toupper(mode())}                   " mode
set statusline +=%#Cyan#                                " filepath color
set statusline +=\ %F                                   " filepath
set statusline +=%{&readonly?'\ [r]':''}                " read-only
set statusline +=%{&modified?'\ [+]':''}                " modified
set statusline +=%=                                     " separator
set statusline +=%#Grey#                                " properties color
set statusline +=\ %{&filetype!=#''?&filetype:'none'}   " filetype
set statusline +=\ (%{&fileencoding})                   " encoding
set statusline +=%#Magenta#                             " position color
set statusline +=\ [%l/%L]                              " line
set statusline +=\ [%c]                                 " col

" remove default mode indicator
set noshowmode

""""""""""""""""""""""""""""""
" tabline

hi TabLineFill  ctermfg=none    ctermbg=none   term=none cterm=none
hi TabLine      ctermfg=grey    ctermbg=none   term=none cterm=none
hi TabLineSel   ctermfg=white   ctermbg=none    term=bold cterm=bold

fun! TabLabel(n)
    let buf = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
    return '['.buf.':'.bufname(buf).']'
endf

fun! TabLine()
    let line = ''
    for i in range(tabpagenr('$'))
        " highlight
        let line .= (i + 1 == tabpagenr())?'%#TabLineSel#':'%#TabLine#' 
        " info
        let line .= ' %{TabLabel('.(i+1).')} '
    endfor
    let line .= '%#TabLineFill#%T'
    return line
endf

set showtabline=2
set tabline=%!TabLine()

""""""""""""""""""""""""""""""
" interactive search
" https://vim.fandom.com/wiki/implement_your_own_interactive_finder_without_plugins

fun! FilterClose(buf)
    wincmd p
    execute 'bwipe' a:buf
    redraw
    echo ''
    return []
endf

fun! Finder(input) abort
    " initialize
    let l:prompt = '> '
    let l:filter = ''
    let l:undoseq = []
    
    " create buffer
    botright 10new +setlocal\ buftype=nofile\ bufhidden=wipe\
        \ nobuflisted\ nonumber\ norelativenumber\ noswapfile\ nowrap\
        \ foldmethod=manual\ nofoldenable\ modifiable\ noreadonly
    let l:cur_buf = bufnr('%')

    " create local list to perform filter
    if type(a:input) ==# v:t_string
        let l:input = systemlist(a:input)
        call setline(1, l:input)
    else
        " assume list
        call setline(1, a:input)
    endif

    " create search prompt
    setlocal cursorline
    redraw
    echo l:prompt

    while 1
        let l:error = 0
        try
            let ch = getchar()
        catch /^Vim:Interrupt$/
            " catch C-c
            return FilterClose(l:cur_buf)
        endtry
        
        " backspace
        if ch ==# "\<bs>"
            let l:filter = l:filter[:-2]
            let l:undo = empty(l:undoseq) ? 0 : remove(l:undoseq, -1)
            if l:undo
                silent norm u
            endif
        " normal char
        elseif ch >=# 0x20
            let l:filter .= nr2char(ch)
            let l:seq_old = get(undotree(), 'seq_cur', 0)
            try
                " filter over the input
                execute 'silent keepp g!:\m'.escape(l:filter, '~\[:').':norm "_dd'
            catch /^Vim\%((\a\+)\=:E?/
                " invalid regexps
                let l:error = 1
            endtry
            " replace buffer if necessary
            let l:seq_new = get(undotree(), 'seq_cur', 0)
            call add(l:undoseq, l:seq_new != seq_old)
        " esc
        elseif ch ==# 0x1B
            return FilterClose(l:cur_buf)
        " enter
        elseif ch ==# 0x0D
            let l:result = empty(getline('.')) ? [] : [getline('.')]
            call FilterClose(l:cur_buf)
            return l:result
        " clear (C-l)
        elseif ch ==# 0x0C
            call setline(1, type(a:input) ==# v:t_string ? l:input : a:input)
            let l:undoseq = []
            let l:filter = ''
            redraw
        " C-k
        elseif ch ==# 0x0B
            norm k
        " C-j
        elseif ch ==# 0x0A
            norm j
        endif
        redraw
        echo (l:error ? '[Invalid pattern]' : '').l:prompt l:filter
    endwhile
endf

" files
fun! FindFiles()
    let choice = Finder('find . -type f')
    if !empty(choice)
        execute 'tabedit ' choice[0]
    endif
endf
nnoremap <leader>e :call FindFiles()<CR>

" most recently used files
fun! FindMRU()
    let choice = Finder(v:oldfiles)
    if !empty(choice)
        execute 'tabedit ' choice[0]
    endif
endf
nnoremap <leader>m :call FindMRU()<CR>

" lines in file
fun! FindLines()
    let choice = Finder('cat -n '.bufname(bufnr('%')))
    if !empty(choice)
        let line_num = substitute(choice[0], '[^0-9]*\([0-9]*\).*', '\1', 'g')
        execute line_num
    endif
endf
nnoremap <leader>f :call FindLines()<CR>

" buffers
fun! FindBuffers()
    let buffers = split(execute('ls'), '\n')
    let choice = Finder(buffers)
    if !empty(choice)
        execute 'buffer' split(choice[0], '\s\+')[0]
    endif
endf
nnoremap <leader>b :call FindBuffers()<CR>


""""""""""""""""""""""""""""""
" auto comment

autocmd FileType python,sh,bash,zsh,ruby,perl let start_comment='#'|let end_comment=''
autocmd FileType html,xml let start_comment='<!--'|let end_comment='--!>'
autocmd FileType php,c,cpp,javascript,css let start_comment='//'|let end_comment=''
autocmd FileType vim let start_comment='"'|let end_comment=''

fun! CommentLines()
    try
        execute 's@^'.g:start_comment.' @@g'
        execute 's@ '.g:end_comment.'$@@g'
    catch
        execute 's@^@'.g:start_comment.' @g'
        execute 's@$@ '.g:end_comment.'@g'
    endtry
endf
noremap <leader>c :call CommentLines()<CR>


""""""""""""""""""""""""""""""
" pairs

" autocomplete
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {; {<CR>};<ESC>O

" override
inoremap "" ""
inoremap () ()
inoremap [] []
inoremap {} {}
inoremap <> <>

" remove
fun! s:RemovePair() abort
    let pair = getline('.')[col('.')-2 : col('.')-1]
    return stridx('""''''()[]{}<>', pair) % 2 == 0 ? "\<del>\<C-h>" : "\<bs>"
endf
inoremap <expr> <bs> <sid>RemovePair()
imap <C-h> <bs>

" surround
xnoremap S) <right>:s!\%V\(.*\)\%V!(\1)!g<CR>
xnoremap S] <right>:s!\%V\(.*\)\%V![\1]!g<CR>
xnoremap S} <right>:s!\%V\(.*\)\%V!{\1}!g<CR>
xnoremap S" <right>:s!\%V\(.*\)\%V!"\1"!g<CR>
xnoremap S' <right>:s!\%V\(.*\)\%V!'\1'!g<CR>


""""""""""""""""""""""""""""""
" panes

" separator 
set fillchars = ""
hi VertSplit ctermbg=black ctermfg=black


""""""""""""""""""""""""""""""
" git tools 

" merge commands 
nnoremap dp :diffput BA<CR>
nnoremap dg :diffget 

" diff colors 
if &diff
    hi DiffAdd          ctermfg=black           ctermbg=lightgreen
    hi DiffChange       ctermfg=none            ctermbg=none
    hi DiffDelete       ctermfg=black           ctermbg=lightred
    hi DiffText         ctermfg=black           ctermbg=lightred
endif


""""""""""""""""""""""""""""""
" netrw

" config 
let g:netrw_banner = 0          " hide that hideous banner
let g:netrw_browse_split = 3    " open in new tab
let g:netrw_altv = 1            " well, well, well...
let g:netrw_liststyle = 3       " expandable directories
let g:netrw_winsize = 23        " col size

" toggle 
nnoremap <silent> <C-n> :Lexplore<CR>

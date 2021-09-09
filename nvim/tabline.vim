" ████████╗ █████╗ ██████╗ ██╗     ██╗███╗   ██╗███████╗  ██╗   ██╗██╗███╗   ███╗
" ╚══██╔══╝██╔══██╗██╔══██╗██║     ██║████╗  ██║██╔════╝  ██║   ██║██║████╗ ████║
"    ██║   ███████║██████╔╝██║     ██║██╔██╗ ██║█████╗    ██║   ██║██║██╔████╔██║
"    ██║   ██╔══██║██╔══██╗██║     ██║██║╚██╗██║██╔══╝    ╚██╗ ██╔╝██║██║╚██╔╝██║
"    ██║   ██║  ██║██████╔╝███████╗██║██║ ╚████║███████╗██╗╚████╔╝ ██║██║ ╚═╝ ██║
"    ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝╚═╝ ╚═══╝  ╚═╝╚═╝     ╚═╝
"
" Author: Igor Andruskiewitsch
" License: MIT
" Notes:
" My Neovim tab line configuration
" Uses Powerlevel Fonts to display the separators

" Set tab line builder
set tabline=%!BuildTabLine()

" {{{ Buffer builder

function! BuildBuffer(bufnr)
    " Create empty buffer name
    let l:buffer_name = ''

    " Don't show telescope buffers
    if getbufvar(a:bufnr, "&syntax") == 'TelescopePrompt'
        return l:buffer_name
    endif

    " Don't show hidden buffers
    if getbufvar(a:bufnr, "&bufhidden") != ''
        return l:buffer_name
    endif

    " Determine buffer name
    if getbufvar(a:bufnr, "&buftype") == 'help'
        " If we're seeing a help pane
        let l:buffer_name .= '[H]'
    elseif getbufvar(a:bufnr, "&modifiable")
        " If we're seeing a modifiable file,
        " check if we're seeing a newly created file
        let l:file_name = fnamemodify(bufname(a:bufnr), ':t')
        let l:buffer_name .= l:file_name != '' ? l:file_name : '[New]'
    endif

    " Add modified flag if needed
    if getbufvar(a:bufnr, "&modified")
        let l:buffer_name .= '(+)'
    endif

    " Highlight current selected buffer
    if a:bufnr == winbufnr(winnr())
        let l:buffer_name = '%#PrimaryBold#' . l:buffer_name . '%#Primary#'
    endif

    " Surround with spaces
    return l:buffer_name . ' '
endfunction

" }}}

" {{{ Tab line builder

function! BuildTabLine()
    let l:tabline = ''

    " Loop through each tab page
    for i in range(tabpagenr('$'))

        " Define tab numbers
        let l:tabnr = i + 1
        let l:next_tabnr = i + 2
        let l:tabsel = l:tabnr == tabpagenr()

        " Initialize highlight color and insert initial space
        let l:tabline .= l:tabsel ? '%#Primary#' : '%#Secondary#'
        let l:tabline .= ' '

        " Set the tab page number (for mouse clicks) and display number
        let l:tabline .= '%' . l:tabnr . 'T'
        let l:tabline .= l:tabnr

        " Parse all buffer names in the current tab
        let l:buffer_names = map(tabpagebuflist(l:tabnr), 'BuildBuffer(v:val)')
        let l:buffer_names = join(l:buffer_names, '')
        let l:tabline .= ' ' . l:buffer_names . ' '

        " Add separator
        if l:tabnr == tabpagenr()
            " If the current tab is selected
            let l:tabline .= '%#PrimarySep#'
        elseif l:next_tabnr == tabpagenr()
            " If the next tab is selected
            let l:tabline .= '%#SecondarySep#'
        else
            " Any other case, use default separator
            let l:tabline .= '%#PrimarySep#'
        endif
    endfor

    " Fill the rest of the tab line
    let l:tabline .= '%#Tertiary#%T'

    return l:tabline
endfunction

" }}}
"

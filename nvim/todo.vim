" ████████╗ ██████╗ ██████╗  ██████╗   ██╗   ██╗██╗███╗   ███╗
" ╚══██╔══╝██╔═══██╗██╔══██╗██╔═══██╗  ██║   ██║██║████╗ ████║
"    ██║   ██║   ██║██║  ██║██║   ██║  ██║   ██║██║██╔████╔██║
"    ██║   ██║   ██║██║  ██║██║   ██║  ╚██╗ ██╔╝██║██║╚██╔╝██║
"    ██║   ╚██████╔╝██████╔╝╚██████╔╝██╗╚████╔╝ ██║██║ ╚═╝ ██║
"    ╚═╝    ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝ ╚═══╝  ╚═╝╚═╝     ╚═╝
"
" Author: Igor Andruskiewitsch
" License: MIT
" Notes:
"   General utils to write TODO lists.
"   Handles files with `.todo` extension.
"   Based on markdown
" Features:
" - Automatic markdown syntax
" - Mappings to perform quick actions

" {{{ Variables

" Global variables

let g:todo_element="- [] <element>"

" Skeletons

let s:element_skeleton=g:todo_element
let s:list_skeleton="# New List\n\n".s:element_skeleton

" Element Patterns

let s:element_pattern='\s*-\s*\[.*\].*'
let s:element_todo_pattern='\s*-\s*\[\s*\].*'
let s:element_wip_pattern='\s*-\s*\[\.].*'
let s:element_done_pattern='\s*-\s*\[x\].*'

" }}}

" {{{ Functions

" To be called whenever a new `.todo` file is opened
function! todo#SetUp()
    " Use markdown syntax
    set filetype=markdown

    " Set up commands
    call todo#SetUpCommands()

    " Set up bindings
    call todo#SetUpBindings()
endfunction

" Create a new List
function! todo#CreateList()
    " Insert snippet
    exec "normal! o".s:list_skeleton

    " Go up two lines
    normal! kk
    " Go to the beginning of the line
    normal! 0
    " Select the first two words (the title)
    normal! wvee
endfunction

" Check if there's an element in the current line
function! todo#IsElement()
    return getline(line('.')) =~ s:element_pattern
endfunction

" Check if we're at the end of an element
function! todo#AtEndOfElement()
    return todo#IsElement() && col(".") == col("$")
endfunction

" Add a new element
function! todo#AddElement()
    " Don't add if there's no element in the current line
    if getline(line('.')) !~ s:element_pattern
        return
    endif

    " Insert snippet
    exec "normal! o".s:element_skeleton

    " Go to the beginning of the line
    normal! 0
    " Select between angle brackets `<>`
    normal! f<
    normal! v%
endfunction

" Toggle element

" The state gets defined by the character between squared brackets:
" `todo` -> []
" `wip` -> [.]
" `done` -> [x]

function! todo#ToggleElement()
    " Mark as `wip`
    if getline(line('.')) =~ s:element_todo_pattern
        s/\[\s*\]/[.]/
        return
    endif

    " Mark as `done`
    if getline(line('.')) =~ s:element_wip_pattern
        s/\[.\]/[x]/
        return
    endif

    " Mark as `todo`
    if getline(line('.')) =~ s:element_done_pattern
        s/\[x\]/[]/
        return
    endif
endfunction

" }}}

" {{{ Auto-commands

" Initial set up when opening files
augroup todo#SetUp
    autocmd BufNewFile,BufRead *.todo call todo#SetUp()
augroup end

" }}}

" {{{ Commands

function! todo#SetUpCommands()
    " Create list command
    command CreateList call todo#CreateList()

    " Add element command
    command AddElement call todo#AddElement()

    " Toggle element command
    command ToggleElement call todo#ToggleElement()
endfunction

" }}}

" {{{ Bindings

function! todo#SetUpBindings()

    " Create new list
    nnoremap <silent> ,c <cmd> CreateList<CR>

    " Add element to the list in the next line
    nnoremap <silent> ,a <cmd> AddElement<CR>

    " Toggle element in the current line
    nnoremap <silent> <Space> <cmd> ToggleElement<CR>

    " Automatically add element
    inoremap <silent><expr> <CR> todo#AtEndOfElement() ? "\<C-O>:call todo#AddElement()\<CR>" : "\<CR>"
endfunction

" }}}

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

" Patterns

let s:element_on_pattern=".*-.*\[x\].*$"
let s:element_pattern=".*-.*\[( )+\].*$"

" }}}

" {{{ Functions

" To be called whenever a new `.todo` file is opened
function! ToDoSetUp()
    " Use markdown syntax
    set filetype=markdown

    " Set up commands
    call ToDoSetUpCommands()

    " Set up bindings
    call ToDoSetUpBindings()
endfunction

" Create a new List
function! ToDoCreateList()
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
function! ToDoIsElement()
    return getline(line('.')) =~ s:element_pattern
endfunction

" Add a new element
function! ToDoAddElement()
    " Don't add if there's no element in the current line
    if getline(line('.')) !~ s:element_pattern
        return
    endif

    " Insert snippet
    exec "normal! o".s:element_skeleton

    " Go to the beginning of the line
    normal! 0
    " Search for the first `<`
    normal! f<
    " Select to the matching `>`
    normal! v%
endfunction

" Toggle element completion

function! ToDoToggleElement()
    " Toggle OFF if it's ON
    if getline(line('.')) =~ s:element_on_pattern
        " Search for the first `x` in the line
        normal! 0fx
        " Delete the `x` and go to the end of the line
        normal! x$
        return
    endif

    " Toggle ON for any other case
    if getline(line('.')) =~ s:element_pattern
        " Go to the first `[` in the line
        normal! 0f[
        " Delete until the matching `]`
        normal! vf]x
        " Insert `[x]`
        normal! i[x]
        " Go to the end of the line
        normal! $
        return
    endif
endfunction

" }}}

" {{{ Auto-commands

" Initial set up when opening files
augroup ToDoSetUp
    autocmd BufNewFile,BufRead *.todo call ToDoSetUp()
augroup end

" }}}

" {{{ Commands

function! ToDoSetUpCommands()
    " Create list command
    command CreateList call ToDoCreateList()

    " Add element command
    command AddElement call ToDoAddElement()

    " Toggle element command
    command ToggleElement call ToDoToggleElement()
endfunction

" }}}

" {{{ Bindings

function! ToDoSetUpBindings()

    " Create new list
    nnoremap <silent> ,c <cmd> CreateList<CR>

    " Add element to the list in the next line
    nnoremap <silent> ,a <cmd> AddElement<CR>

    " Toggle element in the current line
    nnoremap <silent> <Space> <cmd> ToggleElement<CR>

    " Automatically add element
    inoremap <silent><expr> <CR> ToDoIsElement() ? "\<CR>".g:todo_element : "\<CR>"
endfunction

" }}}

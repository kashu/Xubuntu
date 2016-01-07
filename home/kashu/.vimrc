" Modeline and Notes {
"   vim: set foldmarker={,} foldlevel=0:
"   
"   This is my personal .vimrc, I don't recommend you copy it, just
"   use the pieces you want. 
"   Contact me : tuantuan <dangoakachan@foxmail.com>
"
"   Modifier: kashu: https://kashu.org  Email: kashuorg@163.com
"   Last updated: 2015-08-03
" }

let g:LargeFile=10

" Basics {
    set nocompatible    " explicitly get out of vi-compatible mode
    filetype plugin indent on   " load filetype plugins/indent settings
    syntax on           " syntax highlight on

    set backspace=indent,eol,start    " make backspace a more flexible
    set clipboard+=unnamed   " share window clipboard
    set fileformats=unix,dos,mac " support all three, in this order

    let &keywordprg=':help'		      " program to use for the |K| command.  
    let mapleader=','

    " Encodings {
        set enc=utf-8		" Sets the character encoding used inside Vim.
        set fenc=utf-8	    " Sets the character encoding for the file.
        set fencs=ucs-bom,utf-8,gb18030,gbk,gb2312,cp936		
    " }

    " set backup    " make backup files
    " set backupdir=$HOME/.vim/backup " where to put backup files
    " set autochdir  " always switch to the current file directory
" }

" Vim UI {
		set pastetoggle=<F9>
		"set paste
    set number  " turn on line number
    set numberwidth=2   " we are good up to 99999 lines
    set report=0    " tell us when anything is changed via :...
    set ruler   " always show current positions along the bottom
    set showcmd " show the command being typed
    set showmode    " show editing mode
    set showmatch   " show matching brackets
    set matchpairs+=<:>
    set splitbelow " show split window below
    set splitright
    set completeopt=longest,menu    " use a pop up menu for completions

    " Highlight {
        "set cursorcolumn    " highlight the current column
        highlight cursorcolumn guibg=lightblue

        set cursorline  " highlight the current line
        highlight cursorline cterm=bold
        "highlight linenr ctermfg=darkcyan
    " }

    " Colorscheme {
        set background=dark
        "colorscheme solarized " my color scheme
        "colorscheme evening " my color scheme
        let g:solarized_termcolors=256
    " }

    " Search {
        set hlsearch    " highlight search result.
        set incsearch   " do search as you type your search phrase
        set ignorecase smartcase    " smart ignore case when searching.
    " }

    " Statusline {
        set laststatus=2    " always show the status line
        set statusline=
        set statusline+=%-3.3n                       " buffer number
        set statusline+=%t                           " filename
        set statusline+=%h%m%r%w                     " status flags
        set statusline+=[%{&ff}]                     " file format
        set statusline+=[%{strlen(&ft)?&ft:'none'}]  " file type
        set statusline+=%=                           " right align remainder
        set statusline+=0x%-8B                       " character value
        set statusline+=%-14(%l,%c%V%)               " line, character
        set statusline+=%<%LL                        " file lines
    " }
" }

" Text Formatting/Layout {
    set textwidth=79
    set completeopt=menu    " use a pop up menu for completions
    set wildmenu    " turn on command line complete wild style
    set wildignore=*.dll,*.bak,*.exe,*.pyc  " ignore these list file extension
    set formatoptions=tcrql

    " Indent {
        set autoindent
        set smartindent
        set cindent "  enable automatic C program indenting.  
    " }

    " Tab {
        set tabstop=2   " real tabs should be 4
        set shiftwidth=2    " auto-indent amount
        "set expandtab   " no real tabs please!
        set smarttab 
    " }
" } 

" Plugin Settings {
    " Tagbar Settings {
"        let g:tagbar_ctags_bin = "ctags"
"        "let g:tagbar_width = 30
"        let g:tagbar_width = 16
"        let g:tagbar_autoshowtag = 1
"        let g:tagbar_left = 1
"
"        nnoremap <Leader>t :TagbarToggle<CR>
"        autocmd FileType js.css,php,py,sh,h,c,cpp nested :TagbarOpen
    " }

"    " NERDTree {
"        let g:NERDTreeWinPos = "left"
"        let g:NERDTreeDirArrows = 1
"
"        nnoremap <Leader>n :NERDTreeToggle<CR>
"
"        au VimEnter * NERDTree | wincmd p
"        autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"    " ｝

    " Python Syntax {
        let g:python_highlight_file_headers_as_comments = 1
        let g:python_highlight_all = 1
        let g:python_version_2 = 1
    " }
  " }

" Mappings {
"   " Insert time
"    nnoremap <F5> "=strftime("%Y-%m-%d %H:%M:%S")<CR>P
"    inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
"
"    " Easy edit of files in the same directory.
"    if has('unix')
"        nnoremap ,e :e <C-R>=expand("%:p:h") . "/" <CR>
"    else
"        nnoremap ,e :e <C-R>=expand("%:p:h") . "\\" <CR>
"    endif
" }

" User-defind {
    " Abbreviations { " use <space> or <ctrl_]> to expand
        " Typical keypress errors:
        iabbr teh the

        " Abbreviations for some words in common use
        iabbr #c  # coding=utf-8
        iabbr #p  #!/usr/bin/python
        iabbr #b  #!/bin/bash
    " }
" } 

" GUI Settings {
    if has('gui_running')
        set lines=35 columns=150 " size of gvim window

        " Remove toolbar and menubar
        set guioptions-=T
        set guioptions-=m

        " Font. Very important.
        if has('win32') || has('win64')
            set guifont=Consolas:h11:cANSI
        elseif has('gui_macvim')
            set transparency=10
            set guifont=Monaco:h14
            "set showtabline=2

            " Remove scrollbar also
            set guioptions-=r
            set guioptions-=R
            set guioptions-=l
            set guioptions-=L
        elseif has('unix')
            set guifont=Monospace\ 14
        endif
    endif
" }

map <F5> :call TitleDet()<cr>'s                         
function AddTitle()                                     
    call append(0,"#!/bin/bash")                        
    call append(1,"#Author: kashu")                     
    call append(2,"#My Website: https://kashu.org")                     
    call append(3,"#Date: ".strftime("%Y-%m-%d"))       
    call append(4,"#Filename: ")                        
    call append(5,"#Description: ")                     
    call append(6,"")                                   
endf                                                    
                                                        
function UpdateTitle()                                  
    normal m'                                           
    execute '/# *Date:/s@:.*$@\=strftime(": %Y-%m-%d")@'
    normal ''                                           
    normal mk                                           
    execute '/# *Filename:/s@:.*$@\=": ".expand("%:t")@'
    execute "noh"                                       
    normal 'k                                           
endfunction                                             
                                                        
function TitleDet()                                     
    let n=1                                             
    while n < 5                                         
        let line = getline(n)                           
        if line =~ '^\#\s*\S*Date:\S*.*$'               
            call UpdateTitle()                          
            return                                      
        endif                                           
        let n = n + 1                                   
    endwhile                                            
    call AddTitle()
endfunction

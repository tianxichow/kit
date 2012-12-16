
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Antares Chow
"2012-12-16

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"general
syntax on
filetype plugin indent on

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hlsearch
set textwidth=80

"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tab, fold and indent related
set foldlevel=99
set foldmethod=syntax
set foldenable
set foldmethod=marker
set autoindent
set smartindent
set wrap
set tabstop=2
set sw=2
au FileType python setl ts=4 sw=4 sts=4  
au FileType sh setl ts=4 sw=4 sts=4
set expandtab
map <F5> gg=G :call Myindent()<CR>

func Myindent()
    %s/\(^\s*$\n\)\(^\s*$\n\)*/\r
    %s/\s*$//
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open files related
set autoread
set nobackup
set noswapfile

try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry


autocmd BufNewFile *.h,*.c,*.cc,*.cpp,*.sh,*.py exec ":call SetTitle()"

func SetTitle()
    if &filetype == 'sh' 
        call setline(1, "\# ############################################")
        call append(line("."), "\# Filename: ".expand("%"))
        call append(line(".")+1, "\# Author: Antares Chow")
        call append(line(".")+2, "\# Mail: homelandbibi@gmail.com")
        call append(line(".")+3, "\# CreateTime: ".strftime("%c"))
        call append(line(".")+4, "\# ############################################")
        call append(line(".")+5, "\#! /bin/bash")
        call append(line(".")+6, "") 
    elseif &filetype == "python"     
        call setline(1, "\# ###########################################")
        call append(line("."), "\# Filename: ".expand("%"))
        call append(line(".")+1, "\# Author: Antares Chow")
        call append(line(".")+2, "\# Mail: homelandbibi@gmail.com")
        call append(line(".")+3, "\# CreateTime: ".strftime("%c"))
        call append(line(".")+4, "\# ########################################")
        call append(line(".")+5, "\#! /bin/python")
        call append(line(".")+6, "") 
    else
        call setline(1, "\/*********************************************")
        call append(line("."), "\* Filename: ".expand("%"))
        call append(line(".")+1, "\* Author: Antares Chow")
        call append(line(".")+2, "\* Mail: homelandbibi@gmail.com")
        call append(line(".")+3, "\* CreateTime: ".strftime("%c"))
        call append(line(".")+4, "*********************************************/")
        call append(line(".")+5, "")
    endif
    exec "$"
endfunc

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" complie and debug

set wildignore=*.o,*.pyc
map <F6> :call CompileRun()<CR>

func CompileRun()
    exec "w"
    if &filetype == 'c'
        exec "!gcc -Wall -g % -o %<"
        exec "! ./%<"
    elseif &filetype == "cpp"
        exec "!g++ -Wall -g % -o %<"
        exec "! ./%<"
    elseif &filetype == "sh"
        exec "! ./%"
    elseif &filetype == "python"
        exec "!python %"
    endif
endfunc

au QuickFixCmdPost make cw

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


syntax enable
set nocp
set bs=2
set bg=dark
set sw=4
set ts=4
set ai
set expandtab

set wmh=0
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

au BufRead,BufNewFile *.go set filetype=go
au! Syntax go source ~/.vim/go.vim

syntax enable
set nocp
set bs=2
set bg=dark
set sw=4
set ts=4
set ai
set expandtab
set smarttab
filetype plugin indent on
set hidden
set ruler
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>
set shortmess=atI
set ignorecase
set smartcase
set wildmenu
set wildmode=list:longest
set history=1000
let mapleader=","
nnoremap ' `
nnoremap ` '

" After splitting window, Ctrl-J and Ctrl-K to switch between at full height
set wmh=0
nmap <C-J> <C-W>j<C-W>_
nmap <C-K> <C-W>k<C-W>_

au BufRead,BufNewFile *.go set filetype=go
au! Syntax go source ~/.vim/go.vim

filetype off
filetype plugin indent off
call pathogen#infect()
filetype plugin indent on
set nocp
set nomodeline

set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

set wrap
set textwidth=80
set colorcolumn=85
set formatoptions=croqn1

syntax enable
set bg=dark
colorscheme solarized

set encoding=utf-8
set autoindent
set showcmd
set scrolloff=3
set ruler
set hidden
set wildmenu
set wildmode=list:full
set title
set visualbell
set relativenumber
set cursorline
set ttyfast
set laststatus=2
set bs=2

let mapleader = ","

nnoremap / /\v
vnoremap / /\v

set showmatch
set incsearch
set hlsearch
nnoremap <leader><space> :noh<CR>

set ignorecase
set smartcase
set showmatch

set nolist
set listchars=tab:▸\ ,eol:¬
nnoremap <leader>l :set list!<CR>
" Invisible character colors
highlight NonText guifg=#444444
highlight SpecialKey guifg=#444444

if v:version >= 703
    set undofile
    set undodir=~/.vim/undo//
endif

if has("gui_running")
    set guioptions-=T
    set guifont=Inconsolata:h16
    " Save all buffers when vim loses focus
    au FocusLost * :wa
endif

map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
set wmh=0

set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/backup//

set showcmd " Echo command as it is being typed

iab <svg> <svg xmlns="http://www.w3.org/2000/svg">

" Navigate buffers with option-{left,right}
nmap <A-Left> :bp<CR>
nmap <A-Right> :bn<CR>

nmap j gj
nmap k gk

" Fold HTML tag
nnoremap <leader>ft Vatzf

" Strip trailing whitespace
match Error /\s\+$/
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>

" Re-wrap paragraphs
nnoremap <leader>q gqip

" Open a new split window
nnoremap <leader>w <C-W>s<C-W>k

" Open a new buffer in a new split window
nnoremap <leader>N <C-W>s<C-W>k:enew<CR>i

" The Silver Searcher: https://github.com/rking/ag.vim
nnoremap <leader>a :Ag

" Save a file as root
nnoremap <leader>wr :w ! sudo tee % > /dev/null<CR>

" Run the make command
nnoremap <leader>m :make<CR>

" Reformat paragraphs (wrap long lines)
nnoremap <leader>fm vip:!fmt -w 78<CR>
vnoremap <leader>fm :!fmt -w 78<CR>

" Edit and source ~/.vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Add golint (:Lint).
set rtp+=/Users/paul/gocode/src/github.com/golang/lint/misc/vim

if has("autocmd")
    " Ensure tabs in Makefiles.
    autocmd FileType make setlocal noexpandtab
    " Support Format-Flowed in email (mutt).
    autocmd FileType mail setlocal fo+=aw tw=72
    " Fix up imports in Go.
    autocmd FileType go let g:gofmt_command = "goimports"
    autocmd FileType go au BufWritePre <buffer> Fmt
    " Run golint on :w.
    autocmd BufWritePost,FileWritePost *.go execute ':Lint' | cwindow
endif

" Read in full licenses
nnoremap <leader>la :r ~/licenses/apache<CR>
nnoremap <leader>lg :r ~/licenses/gplv2<CR>
nnoremap <leader>lm :r ~/licenses/mit<CR>
" License snippets for fast insertion into source code.
nnoremap <leader>lba :r !sed -n '189,$p' ~/licenses/apache<CR>
nnoremap <leader>lbg :r !sed -n '293,308p' ~/licenses/gplv2<CR>
nnoremap <leader>lbm :r ~/licenses/mit<CR>

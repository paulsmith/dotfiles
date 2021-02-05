" basic settings {{{
set nocompatible
set backspace=2
set autoindent
set autochdir
set noexpandtab
set smarttab
set copyindent
set preserveindent
set smartindent
set background=dark
set hlsearch
set incsearch
set number
set relativenumber
set tabstop=4
set shiftwidth=0
set softtabstop=4
set shiftround
set showmatch
set hidden
set ruler
set laststatus=2 " always show status line, not just >1 window
set foldlevelstart=0 " all folds closed
set signcolumn=yes
syntax enable
" }}}
" undo, swap, and backups {{{
set undodir^=$HOME/.vim/undo//
set undofile
set directory^=$HOME/.vim/swap//
set backup
set backupdir^=$HOME/.vim/backup//
set writebackup
set backupcopy=yes
augroup ps_backups
	autocmd!
	autocmd BufWritePre * let &bex = '@' . strftime("%F.%H:%M")
augroup END
" }}}
" leader {{{
let mapleader = ","
let maplocalleader = "_"
" }}}
" highlights and colors {{{
set list
set listchars=tab:>-,trail:.,extends:>,precedes:<
set colorcolumn=80
nnoremap <leader><space> :nohl<cr>
highlight ColorColumn ctermbg=237
highlight SpecialKey ctermfg=234
highlight LineNr ctermfg=234
highlight Search ctermfg=grey ctermbg=blue
filetype plugin indent on
" }}}
" settings for go {{{
let g:go_fmt_command = "goimports"
" }}}
" uppercase current word {{{
inoremap <c-u> <esc>viwUeA
nnoremap <c-u> viwUeeb
" }}}
" edit ~/.vimrc {{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" }}}
" abbreviations {{{
iabbrev @@ paulsmith@gmail.com
" }}}
" window navigation {{{
set winminheight=0
nnoremap <C-j> <C-w>j<C-w>_
nnoremap <C-k> <C-w>k<C-w>_
" }}}
" wrap word or visual block in quotes {{{
nnoremap <leader>" ea"<esc>bi"<esc>lel
nnoremap <leader>' ea'<esc>bi'<esc>lel
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>
vnoremap <leader>' <esc>`<i'<esc>`>a"<esc>
" }}}
" settings for python {{{
augroup ps_python
	autocmd!
	autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>
	autocmd FileType python vnoremap <buffer> <localleader>c <esc>`<<c-v>`>0I# <esc>
augroup end
" }}}
" settings for zig {{{
augroup ps_zig
	autocmd!
	autocmd FileType zig nnoremap <buffer> <localleader>c I// <esc>
	autocmd FileType zig vnoremap <buffer> <localleader>c <esc>`<<c-v>`>0I// <esc>
augroup end
" }}}
" FZF integrations {{{
if has('osx') && isdirectory('/opt/homebrew/opt/fzf')
	set rtp+=/opt/homebrew/opt/fzf
endif
augroup ps_fzf
	autocmd!
	autocmd VimEnter * if exists(":Files") | nnoremap <leader>f :Files<cr> | endif
	autocmd VimEnter * if exists(":Buffers") | nnoremap <leader>b :Buffers<cr> | endif
	autocmd VimEnter * if exists(":Rg") | nnoremap <leader>r :Rg<cr> | endif
	autocmd VimEnter * if exists(":BLines") | nnoremap <leader>/ :BLines<cr> | endif
	autocmd VimEnter * if exists(":Lines") | nnoremap <leader>l :Lines<cr> | endif
augroup END
" }}}
augroup ps_section " {{{
	nnoremap [[ ?{<CR>w99[{
	nnoremap ][ /}<CR>b99]}
	nnoremap ]] j0[[%/{<CR>
	nnoremap [] k$][%?}<CR>
augroup END
" }}}
" settings for Vimscript {{{
augroup ps_vimscript
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
" }}}

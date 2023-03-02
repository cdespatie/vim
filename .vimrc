" Plugins
" --------
call plug#begin('~/.vim/plugged')
call plug#end()

" Settings
" --------
syntax on
filetype plugin indent on

set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set clipboard   =unnamed
set expandtab
set breakindent
set noswapfile
set nohlsearch
set incsearch
set number
set ignorecase smartcase

" Mappings
" --------
let mapleader = " "

inoremap jk <esc>
nnoremap <leader><leader> .

" Splits, creation and navigation
nnoremap <leader>s <C-W>v
nnoremap <leader>h <C-W>s
nnoremap <leader>w <c-W>w
nnoremap <c-j> <c-W>j
nnoremap <c-k> <c-W>k
nnoremap <c-h> <c-W>h
nnoremap <c-l> <c-W>l

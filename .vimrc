execute pathogen#infect()

""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITOR SETTINGS
""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
syntax on

set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
set breakindent

set number

set ignorecase smartcase
set incsearch

set ttyfast
set lazyredraw

set clipboard=unnamed

""""""""""""""""""""""""""""""""""""""""""
" OS-SPECIFIC SETTINGS
""""""""""""""""""""""""""""""""""""""""""
" Enable DirectX font rendering on Windows
if has("directx") && $VIM_USE_DIRECTX != '0'
  set renderoptions=type:directx,geom:1,taamode:1
endif

""""""""""""""""""""""""""""""""""""""""""
" KEYMAPS
""""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<Space>"

inoremap jk <esc>

nnoremap <leader><leader> .

" Create splits with leader
nnoremap <leader>s <C-W>v 
nnoremap <leader>h <C-W>s 

" Rotate between splits
nnoremap <leader>w <c-W>w

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-W>j
nnoremap <c-k> <c-W>k
nnoremap <c-h> <c-W>h
nnoremap <c-l> <c-W>l

""""""""""""""""""""""""""""""""""""""""""
" AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""
" Set indentation correctly for ruby files
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2

""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Taken from Gary Bernhardt
" NOTE: Doesn't work in VsVim
""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>


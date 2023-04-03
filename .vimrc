" Plugins
" --------
call plug#begin('~/.vim/plugged')
Plug 'elihunter173/dirbuf.nvim', {'branch': 'main'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

Plug 'benmills/vimux'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-fugitive'

Plug 'sainnhe/everforest'
call plug#end()

" Settings
" --------
syntax on
filetype plugin indent on

set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set clipboard   =unnamedplus
set expandtab
set breakindent
set noswapfile
set nohlsearch
set incsearch
set number
set ignorecase smartcase

" Colours
" --------
if has('termguicolors')
  set termguicolors
endif

set background=dark
let g:everforest_background = 'hard'
let g:everforest_better_performance = 1

colorscheme everforest

" Mappings
" --------
let mapleader = " "

inoremap jk <esc>
nnoremap <leader><leader> .

" Splits - creation, resizing, navigation
nnoremap <leader>s <C-W>v
nnoremap <leader>h <C-W>s
nnoremap <leader>w <c-W>w
nnoremap <c-j> <c-W>j
nnoremap <c-k> <c-W>k
nnoremap <c-h> <c-W>h
nnoremap <c-l> <c-W>l
nnoremap <silent> <s-j> :vertical res +3<CR>
nnoremap <silent> <s-l> :vertical res -3<CR>

" Fat fingers
command! W w
command! Q q

nnoremap <silent> <Leader>t :TestFile<CR>

" Plugin Settings
" --------
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-o> <cmd>Telescope live_grep<cr>

let test#strategy = "vimux"
let g:VimuxHeight = "30"

" Autocmds
" --------
augroup rubygroup
    autocmd!
    autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
augroup END

augroup pythongroup
    autocmd!
    autocmd FileType python nnoremap <Leader>r :call VimuxRunCommand("clear; python3 " . bufname("%"))<CR>
augroup END

augroup jsgroup
    autocmd!
    autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2
augroup END

augroup jsongroup
    autocmd!
    autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
augroup END


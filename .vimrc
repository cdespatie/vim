call plug#begin('~/.vim/plugged')
" Directory menu
Plug 'elihunter173/dirbuf.nvim', {'branch': 'main'}

" Fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Manage tmux splits
Plug 'benmills/vimux'

" Testing
Plug 'janko-m/vim-test'
Plug 'tpope/vim-fugitive'

" Better comments
Plug 'tpope/vim-commentary'

" Syntax highlighting
Plug 'hashivim/vim-terraform'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" AI
Plug 'github/copilot.vim', {'branch': 'release'}

" Themes
Plug 'navarasu/onedark.nvim'

call plug#end()

" Startup speed hax
if has('linux')
    let g:python3_host_prog='/usr/bin/python3'
endif

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

colorscheme onedark

" Mappings
" --------
let mapleader = " "

inoremap jk <esc>
nnoremap <leader><leader> .

" Splits - creation, resizing, navigation

" Create splits
nnoremap <leader>s <C-W>v
nnoremap <leader>h <C-W>s

"Nav clockwise/couterclockwise
nnoremap <leader>w <c-W>w
nnoremap <leader>q <c-W>W

nnoremap <silent> <s-j> :vertical res +3<CR>
nnoremap <silent> <s-l> :vertical res -3<CR>

" Fat finger saving and quitting
command! W w
command! Q q

" Plugin Settings
" --------

" Fzf
nnoremap <C-p> <cmd>Files<cr>
nnoremap <C-o> <cmd>Rg<cr>

" Fugitive
nnoremap <silent> <Leader>t :TestFile<CR>

" vim-test
let test#strategy = "vimux"
let g:VimuxHeight = "20"

" Treesitter
lua << EOF
require('nvim-treesitter.configs').setup({
    ensure_installed = { "python", "ruby", "javascript", "json", "typescript", "vim", "lua" },
    highlight = {
      enable = true,
    },
})
EOF

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


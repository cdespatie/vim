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

" Don't need this since we're using airline
set noshowmode

set clipboard=unnamed

""""""""""""""""""""""""""""""""""""""""""
" THEME SETTINGS
""""""""""""""""""""""""""""""""""""""""""
if has("unix")
    colorscheme apprentice
endif

" gVim specific settings
if has("gui_running")
    set guioptions-=T " Remove toolbar in gVim
    set guioptions-=L " Remove left scrollbar in gVim
    colorscheme apprentice

    " Windows has different font syntax
    if has("win32") || has("win64")
        set guifont=Fira_Mono_for_Powerline:h10:cANSI
    endif

endif

" Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_left_sep=''
let g:airline_right_sep=''

""""""""""""""""""""""""""""""""""""""""""
" OS-SPECIFIC SETTINGS
""""""""""""""""""""""""""""""""""""""""""
" Enable DirectX font rendering on Windows
if has("directx") && $VIM_USE_DIRECTX != '0'
  set renderoptions=type:directx,geom:1,taamode:1
endif

" Change cursor shape by mode in iTerm2
" This is done by default in cmder
if $TERM_PROGRAM =~ "iTerm.app"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
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


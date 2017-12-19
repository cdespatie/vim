""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
" Install plugins with ':PlugInstall'
""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" General-use plugins
Plug 'tpope/vim-sensible'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'

" Programming plugins
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'

" Writing plugins
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Language-specific plugins
Plug 'mxw/vim-jsx'
Plug 'cespare/vim-toml'
Plug 'vim-ruby/vim-ruby'
Plug 'OrangeT/vim-csharp'
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'

" Colorschemes
Plug 'ajmwagar/vim-deus'
Plug 'romainl/Apprentice'
Plug 'joshdick/onedark.vim'

call plug#end()

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
" PLUGIN SETTINGS
""""""""""""""""""""""""""""""""""""""""""
" Pandoc
let g:pandoc#modules#disabled = ["folding"]

" Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_detect_whitespace = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" Easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""
" THEME SETTINGS
""""""""""""""""""""""""""""""""""""""""""
colorscheme apprentice

" gVim specific settings
if has("gui_running")
    set guioptions-=T " Remove toolbar in gVim
    set guioptions-=L " Remove left scrollbar in gVim ('r' is right)

    " Windows has different font syntax
    if has("win32") || has("win64")
        set guifont=Hack:h9:cANSI
        set rop=type:directx,geom:1,taamode:1
        set enc=utf-8
    endif
endif

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

" Move lines of code around with ctrl-arrows
nnoremap <silent> <c-Up>   :<C-u>move-2<CR>==
nnoremap <silent> <c-Down> :<C-u>move+<CR>==
xnoremap <silent> <c-Up>   :move-2<CR>gv=gv
xnoremap <silent> <c-Down> :move'>+<CR>gv=gv

""""""""""""""""""""""""""""""""""""""""""
" AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""
" Set indentation correctly for ruby files
augroup rubygroup
    autocmd!
    autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
augroup END

augroup bufferswitch
    autocmd!
    if v:version >= 700
      au BufLeave * let b:winview = winsaveview()
      au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
    endif
augroup END

augroup disablebells
    set noerrorbells visualbell t_vb=
    autocmd GUIEnter * set visualbell t_vb=
augroup END

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


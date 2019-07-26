""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
" Install plugins with ':PlugInstall'
""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" General-use plugins
Plug 'tpope/vim-sensible'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'vim-airline/vim-airline'
Plug '/usr/local/opt/fzf'
Plug 'ludovicchabant/vim-gutentags'

" Programming plugins
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-fugitive'

" Writing plugins
Plug 'reedes/vim-pencil'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'junegunn/goyo.vim'

" Language-specific plugins
Plug 'mxw/vim-jsx'
Plug 'cespare/vim-toml'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'OrangeT/vim-csharp'
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'hail2u/vim-css3-syntax'

" Colorschemes
Plug 'romainl/Apprentice'
Plug 'morhetz/gruvbox'

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
set noswapfile

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

" vim-pencil
let g:pencil#wrapModeDefault = 'soft'

" vim-test
let test#strategy = "vimterminal"

" This is to force vim-test to use `bundle exec rspec`
" Otherwise it uses something called binstubs..?
let test#ruby#use_binstubs = 0

" RLS
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
    let g:ale_linters = {'rust': ['rls']}
endif

" FZF
nnoremap <c-p> :FZF<cr>
augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

""""""""""""""""""""""""""""""""""""""""""
" THEME SETTINGS
""""""""""""""""""""""""""""""""""""""""""
let g:gruvbox_invert_selection = 0
set background=dark
colorscheme gruvbox

" termguicolors working under tmux requires this
let &t_8f = "[38;2;%lu;%lu;%lum"
let &t_8b = "[48;2;%lu;%lu;%lum"
set termguicolors

" gVim specific settings
if has("gui_running")
    set guioptions-=T " Remove toolbar in gVim
    set guioptions-=L " Remove left scrollbar in gVim ('r' is right)
endif

" Windows has different font syntax
if has("win32") || has("win64")
    set guifont=Hack:h9:cANSI
    set rop=type:directx,geom:1,taamode:1
    set enc=utf-8
endif

""""""""""""""""""""""""""""""""""""""""""
" OS-SPECIFIC SETTINGS
""""""""""""""""""""""""""""""""""""""""""
" Enable DirectX font rendering on Windows
if has("directx") && $VIM_USE_DIRECTX != '0'
  set renderoptions=type:directx,geom:1,taamode:1
endif

set t_SI=[6\ q
set t_SR=[4\ q
set t_EI=[2\ q

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

" vim-test bindings
nnoremap <silent> <Leader>t :TestFile<CR>

""""""""""""""""""""""""""""""""""""""""""
" AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""
" Set indentation correctly for ruby files
augroup rubygroup
    autocmd!
    autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
augroup END

" Set indentation for WS JS files
augroup jsgroup
    autocmd!
    autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2
augroup END


augroup bufferswitch
    autocmd!
    if v:version >= 700
      au BufLeave * let b:winview = winsaveview()
      au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
    endif
augroup END

augroup pencil
  autocmd!
  autocmd FileType text         call pencil#init()
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


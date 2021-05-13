""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
" Install plugins with ':PlugInstall'
""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" General-use plugins
Plug 'tpope/vim-sensible'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Programming plugins
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-fugitive'
Plug 'benmills/vimux'

" Writing plugins
Plug 'reedes/vim-pencil'

" Language-specific plugins
Plug 'mxw/vim-jsx'
Plug 'cespare/vim-toml'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'OrangeT/vim-csharp'
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'hail2u/vim-css3-syntax'

" COC
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Colorschemes
Plug 'romainl/Apprentice'
Plug 'nanotech/jellybeans.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""
" THEME SETTINGS
""""""""""""""""""""""""""""""""""""""""""
colorscheme jellybeans

" termguicolors working under tmux requires this
let &t_8f = "[38;2;%lu;%lu;%lum"
let &t_8b = "[48;2;%lu;%lu;%lum"
set termguicolors

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
set nohlsearch

set number

" Hides gutter (signs) column
set scl=auto

set ignorecase smartcase
set incsearch

set ttyfast
set lazyredraw

" Don't need this since we're using airline
set noshowmode

set clipboard=unnamed

" Disable folding for {/}
set foldopen-=block

""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SETTINGS
""""""""""""""""""""""""""""""""""""""""""
" Neovim + python + pyenv settings
let g:python_host_prog = '/Users/cdespatie/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/cdespatie/.pyenv/versions/neovim3/bin/python'

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
let g:pencil#wrapModeDefault = "soft"

" vim-test
let test#strategy = "vimux"
let g:VimuxHeight = "30"

" Bind for getting out of weird insert mode
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

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
augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

nnoremap <c-p> :FZF<cr>
nnoremap <c-o> :Rg<cr>
nnoremap <c-\> :CocCommand eslint.executeAutofix<cr>

" Use rg for ctrl-p
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options' : '--delimiter : --nth 4..'}, 'up:60%'), <bang>0)

""""""""""""""""""""""""""""""""""""""""""
" KEYMAPS
""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "

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

" Folding
nnoremap <leader>; za

" Split Resizing
nnoremap <silent> <s-j> :vertical res +3<CR>
nnoremap <silent> <s-l> :vertical res -3<CR>

" Remaps capital W and capital Q because my fingers are fat
command! W w
command! Q q

""""""""""""""""""""""""""""""""""""""""""
" AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""
" Set indentation correctly for ruby files
augroup rubygroup
    autocmd!
    autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
augroup END

augroup rust
    autocmd!
    autocmd FileType rust map <Leader>r :wa<CR> :CargoRun<CR>
augroup END
"
" Set indentation correctly for json files
augroup jsongroup
    autocmd!
    autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
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
" OS-SPECIFIC SETTINGS
""""""""""""""""""""""""""""""""""""""""""
set t_SI=[6\ q
set t_SR=[4\ q
set t_EI=[2\ q

""""""""""""""""""""""""""""""""""""""""""
" COC SETTINGS
""""""""""""""""""""""""""""""""""""""""""
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
" set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


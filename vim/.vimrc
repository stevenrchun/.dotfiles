set nocompatible

" Automatically install Vim Plug if not available.
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set rtp+=/usr/local/opt/fzf
call plug#begin()
	Plug 'itchyny/lightline.vim' " A better status line at the bottom
	Plug 'jiangmiao/auto-pairs' " Pairs brackets n things
  Plug 'mengelbrecht/lightline-bufferline' "Use the tabline for buffers
  Plug 'terryma/vim-smooth-scroll' " Smooth out scrolling commands
  Plug 'srcery-colors/srcery-vim' " Srcery colorscheme
  Plug 'junegunn/fzf.vim' " FZF vim plugin
  Plug 'junegunn/fzf' " FZF vim plugin
  Plug 'haya14busa/incsearch.vim' " Incremental search
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx' " JSX syntax
  Plug 'chrisjohnson/vim8-bracketed-paste-mode-tmux' " make proper indentation inside tmux
  Plug 'tpope/vim-commentary' " simple commenting
  Plug 'nikvdp/ejs-syntax'
  Plug 'godlygeek/tabular' " required for vim markdown
  Plug 'plasticboy/vim-markdown' " for tex syntax in MD files
  Plug 'udalov/kotlin-vim'
  Plug 'neovim/nvim-lspconfig' " LSP Config Manager
  if !has('nvim')
    Plug 'google/vim-maktaba' " For Google codefmt
    Plug 'google/vim-codefmt'
    Plug 'google/vim-glaive'
  endif
  "Neovim Plugins
  if has('nvim')
    Plug 'karb94/neoscroll.nvim'
    Plug 'sbdchd/neoformat'
    Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }
  endif
call plug#end()

if !has('nvim')
  call glaive#Install()
endif

" ------------------------------------------------------
" Enable modern Vim features not compatible with Vi spec.
" ------------------------------------------------------
set number
set ignorecase
" hide extra insert below status line
set noshowmode
" automatically read in external changes
set autoread
" Update file after 4s of inactivity in normal mode for autoread
au CursorHold * checktime
" No tabs, just spaces. Also explicitly set shiftwidth and tabstop since Go uses
" this for indentation.
set shiftwidth=2 tabstop=2 expandtab
" improve scroll lag
set lazyredraw

set autoindent
set smartindent
filetype plugin indent on
syntax on
set noshowmode
set laststatus=2
set backspace=indent,eol,start
set number
set smartcase
set hlsearch
" Allow hidden, unsaved buffers
set hidden
" always show tabline
set showtabline=2
" ------------------------------------------------------

" Remap leader to space
let mapleader = " "

" Remap exit insert
imap jj <Esc>

" Remap save
map <silent> <C-s> :update<CR>

" Remap half page motion
map <S-j> <C-d>
map <S-k> <C-u>

" BUFFER MANAGEMENT
" remap ctrl-h/j to move buffers
nnoremap <C-h> :bprev<CR>
nnoremap <C-l> :bnext<CR>

" Ctrl-c to close buffer
nnoremap <C-c> :bp\|bd #<CR>

" Colorscheme
" colorscheme srcery
colorscheme molokai

" SEARCH
" Remap in-buffer Search
map <S-f> /

" Remap fzf.vim Ag Project Search in buffer
nnoremap <C-f> :Lines
nnoremap <leader>cs :Ag<space>
nnoremap <leader>ff :Files<CR>
nnoremap ; :Buffers<CR>
let $FZF_DEFAULT_COMMAND='ag --hidden -g ""'

" Search related settings
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Turn off highlighting after first non-search motion
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)

" Language specific syntax
autocmd FileType * set tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
" Prevent typescript hanging, see
" https://vi.stackexchange.com/questions/25086/vim-hangs-when-i-open-a-typescript-file/28721#28721?newreg=b7e9e7a35a2e4ee8806d1900d1c07455
" autocmd FileType typescript set re=2

" Wrap markdown files at 80 characters
autocmd bufreadpre *.md setlocal textwidth=80

" Highlight latex in md files
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1



" Turn on autosave on startup
let g:auto_save = 0

" remap arrow keys
nnoremap <Left> :bprev<CR>
nnoremap <Right> :bnext<CR>

" Code formatters
" Make codefmt work with ejs.
au BufNewFile,BufRead *.ejs set filetype=html

if !has('nvim')
  augroup autoformat_settings
    autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType c,cpp,proto AutoFormatBuffer clang-format
    autocmd FileType javascript,typescript AutoFormatBuffer prettier
    autocmd FileType dart AutoFormatBuffer dartfmt
    autocmd FileType go AutoFormatBuffer gofmt
    autocmd FileType gn AutoFormatBuffer gn
    autocmd FileType html,css,sass,scss,less,json,ejs AutoFormatBuffer js-beautify
    autocmd FileType java AutoFormatBuffer google-java-format
    autocmd FileType python AutoFormatBuffer yapf
    " Alternative: autocmd FileType python AutoFormatBuffer autopep8
    autocmd FileType rust AutoFormatBuffer rustfmt
    autocmd FileType vue AutoFormatBuffer prettier
    autocmd FileType lua AutoFormatBuffer stylua
  augroup END
endif

if has('nvim')
  augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
  augroup END
endif

" use lightline-buffer in lightline
let g:lightline = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

let g:lightline#bufferline#min_buffer_count = 2

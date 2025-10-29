" Automatically install Vim Plug if not available.
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set rtp+=/usr/local/opt/fzf
call plug#begin()
	Plug 'itchyny/lightline.vim' " A better status line at the bottom
  Plug 'mengelbrecht/lightline-bufferline' "Use the tabline for buffers
  Plug 'terryma/vim-smooth-scroll' " Smooth out scrolling commands
  Plug 'srcery-colors/srcery-vim' " Srcery colorscheme
  Plug 'junegunn/fzf.vim' " FZF vim plugin
  Plug 'UtkarshVerma/molokai.nvim' " Neovim molokai
  Plug 'junegunn/fzf' " FZF vim plugin
  Plug 'haya14busa/incsearch.vim' " Incremental search
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx' " JSX syntax
  Plug 'tpope/vim-commentary' " simple commenting
  Plug 'nikvdp/ejs-syntax'
  Plug 'godlygeek/tabular' " required for vim markdown
  Plug 'plasticboy/vim-markdown' " for tex syntax in MD files
  Plug 'udalov/kotlin-vim'
  Plug 'mhinz/vim-signify' " G4 Diffs in gutter
  "Neovim exclusive Plugins
  if has('nvim')
    Plug 'karb94/neoscroll.nvim'
    Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }
    Plug 'rose-pine/neovim' " Light theme!
    Plug 'neovim/nvim-lspconfig' " LSP Config Manager
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
    Plug 'kosayoda/nvim-lightbulb' " Notify if available code actions.
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Treesitter!
    Plug 'stevearc/conform.nvim' " Formatting!
    " Avante Deps
    " Plug 'stevearc/dressing.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'MunifTanjim/nui.nvim'
    Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }
  endif
call plug#end()

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
set laststatus=3
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

" SEARCH
" Remap fzf.vim Ag Project Search in buffer
let $FZF_DEFAULT_COMMAND='ag --hidden -g ""'
" Remap in-buffer Search
map <S-f> /

" FILE NAVIGATION
" Function for population quickfix list with git changed files.
function! ShowGitTouched() abort
  let flist = system('git diff --name-only main')
  let flist = split(flist, '\n')
  let list = map(copy(flist), '{"filename": v:val, "lnum": 1}')
  call setqflist(list)
  :copen
endfunction
nnoremap <C-f> :Lines<CR>
nnoremap <leader>cs :Ag<space>
nnoremap <leader>ff :Files<CR>
nnoremap ; :Buffers<CR>
map <leader>pp :call ShowGitTouched()<CR>

" Search related settings
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Turn off highlighting after first non-search motion
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)

" Wrap markdown files at 80 characters
autocmd bufreadpre *.md setlocal textwidth=80

" Highlight latex in md files
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1

" remap arrow keys
nnoremap <Left> :bprev<CR>
nnoremap <Right> :bnext<CR>

" Make sure ejs is recognized as html.
au BufNewFile,BufRead *.ejs set filetype=html

set bg=light

" PLUGIN SPECIFIC CONFIGURATION
" use lightline-buffer in lightline
" let g:lightline = {
"   \ 'colorscheme': 'rosepine',
"   \ }
let g:lightline = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline#bufferline#min_buffer_count = 2

" Override default styling for tabline for rosepine.
" You can echo this variable to get the colors rosepine uses.
" let s:palette = g:lightline#colorscheme#rosepine#palette
"                                  Text     background
" let s:palette.tabline.tabsel = [['#faf4ed', '#565276', 24, 255]]
" unlet s:palette

" Configure signify
" This makes it so vim reserves the sign column, which
" prevents jitter for signify and LSP help icons.
set signcolumn=yes
let g:signify_vcs_list = ['hg', 'git', 'perforce']
let g:signify_vcs_cmds = {
    \ 'hg': 'hg diff -r .^ --color never --config defaults.diff= --nodates -U0 -- %f',
    \ 'perforce': 'p4 info >& /dev/null && env G4MULTIDIFF=0 P4DIFF=%d p4 diff -dU0 %f',
    \ 'git': 'git diff --no-color --no-ext-diff -U0 main -- %f',
    \ }

" Colorscheme
" colorscheme srcery
" To use molokai: disable lightline theme. Do not source any theme in
" .tmux.conf. Remove fzf coloring in .bash_profile. That should be it.
" colorscheme molokai
"
" colorscheme rose-pine-dawn

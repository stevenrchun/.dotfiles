set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf
call vundle#begin()
	Plugin 'VundleVim/Vundle.vim' " Plugin Manager
	Plugin 'itchyny/lightline.vim' " A better status line at the bottom
	Plugin 'jiangmiao/auto-pairs' " Pairs brackets n things
  Plugin 'scrooloose/nerdtree' " Project tree for files
  Plugin 'mengelbrecht/lightline-bufferline' "Use the tabline for buffers
  Plugin 'vim-scripts/vim-auto-save' " Allow auto-save (currently disabled)
  Plugin 'terryma/vim-smooth-scroll' " Smooth out scrolling commands
  Plugin 'srcery-colors/srcery-vim' " Srcery colorscheme
  Plugin 'junegunn/fzf.vim' " FZF vim plugin
  Plugin 'haya14busa/incsearch.vim' " Incremental search
  " Plugin 'Valloric/YouCompleteMe' " Completion engine
  Plugin 'w0rp/ale' " Async linting engine
  Plugin 'pangloss/vim-javascript'
  Plugin 'mxw/vim-jsx' " JSX syntax
  Plugin 'chrisjohnson/vim8-bracketed-paste-mode-tmux' " make proper indentation inside tmux
  Plugin 'flowtype/vim-flow' " Flow type checking for vim
  Plugin 'tpope/vim-commentary' " simple commenting
  Plugin 'nikvdp/ejs-syntax'
  Plugin 'google/vim-maktaba' " For Google codefmt
  Plugin 'google/vim-codefmt'
  Plugin 'godlygeek/tabular' " required for vim markdown
  Plugin 'plasticboy/vim-markdown' " for tex syntax in MD files
  " Also add Glaive, which is used to configure codefmt's maktaba flags. See
  " `:help :Glaive` for usage.
  Plugin 'google/vim-glaive'
call vundle#end()
call glaive#Install()
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
set lazyredraw
" Allow hidden, unsaved buffers
set hidden
" Peristent Undo
set undofile
set undodir=~/.vim/undodir

" Colorscheme
" colorscheme srcery
colorscheme molokai

" REMAPS
" Remap to end of or beginning of line motions
let mapleader = " "
" Remap close file buffer
nnoremap <C-c> :bp\|bd #<CR>
" Remap next/previous buffer
nnoremap <C-l> :bn<CR>
nnoremap <C-h> :bp<CR>
imap jj <Esc>
" Remap half page motion
noremap <S-j> <c-d>
noremap <S-k> <c-u>
" Remap save
noremap <silent> <c-s> :update<CR>
" Remap in-buffer Search
map <S-f> /
" Remap fzf.vim Ag Project Search in buffer
nnoremap <c-f> :Ag<space>
nnoremap <leader>f :Files<CR>
let $FZF_DEFAULT_COMMAND='ag -g ""'

" Smooth scroll remap
noremap <silent> <S-k> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <S-j> :call smooth_scroll#down(&scroll, 0, 3)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
" noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
" Remap YCM GoTo Definition
noremap gd:YcmCompleter GoTo<CR>
noremap gD:YcmCompleter GoToDeclaration<CR>

" Search related settings
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Turn off highlighting after first non-search motion
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" Language specific syntax
autocmd FileType * set tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab

" Wrap markdown files at 80 characters
autocmd bufreadpre *.md setlocal textwidth=80

" Highlight latex in md files
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1

" Open nerdtree if opening current directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:NERDTreeWinSize=15

nnoremap <C-n> :NERDTreeToggle<CR>

" ALE Settings
let g:ale_open_list = 1
let g:ale_list_window_size = 3
let g:ale_fix_on_save = 1
let g:ale_linters = {
\   'javascript': ['eslint', 'flow']
\}

let g:ale_python_auto_pipenv = 1

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['autopep8'],
 \  'javascript': ['eslint'],
\}
" Don't automatically lint on text change
let g:ale_lint_on_text_changed = 'never'
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0
" turn off completion.
let g:ale_completion_enabled = 0

" Buffer tabs for lightline
"set hidden
"" allow buffer switching without saving
set showtabline=2  " always show tabline

" Turn on autosave on startup
let g:auto_save = 0

" remap arrow keys
nnoremap <Left> :bprev<CR>
nnoremap <Right> :bnext<CR>

" Code formatters
" Make codefmt work with ejs.
au BufNewFile,BufRead *.ejs set filetype=html

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
augroup END

" Point You Complete Me to right python binary in pipenv envs
" Point YCM to the Pipenv created virtualenv, if possible
" At first, get the output of 'pipenv --venv' command.
let pipenv_venv_path = system('pipenv --venv')
" The above system() call produces a non zero exit code whenever
" a proper virtual environment has not been found.
" So, second, we only point YCM to the virtual environment when
" the call to 'pipenv --venv' was successful.
" Remember, that 'pipenv --venv' only points to the root directory
" of the virtual environment, so we have to append a full path to
" the python executable.
if shell_error == 0
  let venv_path = substitute(pipenv_venv_path, '\n', '', '')
  let g:ycm_python_binary_path = venv_path . '/bin/python'
else
  let g:ycm_python_binary_path = 'python'
endif

let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_global_ycm_extra_conf = '.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" Css semantic triggers for YCM
let g:ycm_semantic_triggers = {
    \   'css': [ 're!^\s{2}', 're!:\s+' ],
    \ }


" use lightline-buffer in lightline
let g:lightline = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

let g:lightline#bufferline#min_buffer_count = 2

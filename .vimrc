" Remove ALL autocommands to prevent them from being loaded twice.
if has("autocmd")
    autocmd!
end


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
"

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Behavioral settings
set autoindent    "
set backspace=indent,eol,start   " Set for maximum backspace smartness
set grepprg=ack   " Use ack for grepping
set history=700   " Number of ":" commands and search patterns to remember
"set hlsearch      "
set ignorecase    "
set incsearch     "
set number        "
set magic         "
set modelines=5   "
"set mouse=a       " Enable the mouse
set scrolloff=2   " Minimal number of screen lines to keep above and below the cursor
set showcmd
set showmatch     "
set smartcase     " Overrides 'ignorecase' if search pattern contains upper case characters
set smartindent   "
set laststatus=2
set encoding=utf-8
set numberwidth=5

if v:version >= 730
	set colorcolumn=80
endif

" Visual settings
set guicursor=n-v-c:block-Cursor
set guicursor+=i-ci:ver100-iCursor-blinkkwait300-blinkon200-blink-off100
set listchars=tab:▸\ ,trail:·,eol:¬,extends:»,precedes:«

if v:version > 700
    set cursorline
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle, the plug-in manager for Vim
"
" Install with
"    mkdir -p ~/.vim/bundle && git clone http://github.com/gmarik/vundle.git \
"    ~/.vim/bundle/vundle && vim -c ':BundleInstall' -c ':qa!'
" Update with:
"    vim -c ':BundleInstall!' -c ':BundleClean' -c ':qa!'


" Required!
filetype off

" NOTE: comments after Bundle command are not allowed
function! LoadBundles()
    " Required! Lets Vundle manage Vundle
    Bundle 'gmarik/vundle'

    " GitHub repos
    Bundle 'gcatlin/modokai.vim'
    Bundle 'gcatlin/go-vim.vim'
    Bundle 'mileszs/ack.vim'
    Bundle 'sjl/vitality.vim'
    Bundle 'Lokaltog/vim-powerline'
    Bundle 'Lokaltog/vim-easymotion'
    "Bundle 'Lokaltog/python-syntax'
    "Bundle 'scrooloose/nerdcommenter'
    "Bundle 'scrooloose/nerdtree'
    "Bundle 'scrooloose/syntastic'
    "Bundle 'ervandew/supertab'
    "Bundle 'tpope/vim-repeat'
    "Bundle 'tpope/vim-endwise'
    Bundle 'tpope/vim-surround'
    Bundle 'majutsushi/tagbar'
    "Bundle 'xolox/vim-easytags'
    Bundle "pfdevilliers/Pretty-Vim-Python"

    " vim-scripts repos
    "Bundle 'L9'

    " Other git repos
    "Bundle 'git://git.wincent.com/command-t.git'
endfunction

try
  set runtimepath+=~/.vim/bundle/vundle/
  call vundle#rc()
  call LoadBundles()
:catch /^Vim\%((\a\+)\)\=:E117/
  echomsg "Failed to load vundle and/or bundles. Perhaps vundle isn't installed."
  echomsg "To install vundle: "
  echomsg "   git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle"
  echomsg "   vim -c ':BundleInstall' -c ':qa!'"
endtry

" Required!
filetype plugin indent on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fonts, colors and syntax highlighting
"

if &t_Co > 2 || has("gui_running")
   syntax on
   set t_Co=256
   colorscheme modokai
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automcommands
"
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mappings
"

" Set the mapleader (default is "\")
let mapleader=","
let g:mapleader=","

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Toggles invisible characters
nnoremap <leader>i :set list!<CR>

" Edit .vimrc and re-source on save
nnoremap <leader>. :vsplit $MYVIMRC<CR>
autocmd BufWritePost .vimrc source $MYVIMRC
autocmd BufWritePost .vimrc call Pl#Load()

" Open file in vertically split window
nnoremap <leader>o :Sexplore!<CR>

" Fast saving
nnoremap <leader>w :w!<CR>

" Don't use Ex mode, use Q for formatting
nnoremap Q gq

" Make Y behave like other capitals.
nnoremap Y y$

" Prevent 'x' from adding to register
nnoremap x "_x

" Duplicate a selection
vnoremap D y`>p

" Overwrite Visual mode selection
vnoremap p "_dP

" Prevent highlight being lost on (de)indent
vnoremap < <gv
vnoremap > >gv

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :nohlsearch<CR><CR>

" Show syntax highlighting groups for word under cursor
nnoremap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

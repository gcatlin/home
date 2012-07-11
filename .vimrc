""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
"

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Remove ALL autocommands to prevent them from being loaded twice.
if has("autocmd")
        autocmd!
end

set autoindent
set backspace=indent,eol,start
set cindent
set cursorline
set encoding=utf-8
set expandtab
set grepprg=ack
set hidden
set history=700
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set listchars=tab:▸\ ,trail:·,eol:¬,extends:»,precedes:«
set magic
set modelines=5
set mouse=a
set number
set numberwidth=5
set scrolloff=2
set showcmd
set showmatch
set smartcase
set smartindent
set smarttab
set tags=./tags;
set visualbell
set wildmenu
set wildmode=list:longest

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
        Bundle 'gcatlin/Pretty-Vim-Python'
        Bundle 'gcatlin/go-vim'
        Bundle 'Lokaltog/vim-powerline'
        Bundle 'Lokaltog/vim-easymotion'
        Bundle 'kien/ctrlp.vim'
        Bundle 'majutsushi/tagbar'
        Bundle 'mileszs/ack.vim'
        "Bundle 'Lokaltog/python-syntax'
        "Bundle 'scrooloose/nerdcommenter'
        "Bundle 'scrooloose/nerdtree'
        Bundle 'scrooloose/syntastic'
        "Bundle 'ervandew/supertab'
        Bundle 'sjl/vitality.vim'
        "Bundle 'tpope/vim-repeat'
        "Bundle 'tpope/vim-endwise'
        Bundle 'tpope/vim-surround'
        "Bundle 'xolox/vim-easytags'

        " vim-scripts repos
        "Bundle 'L9'

        " Other git repos
        "Bundle 'git://git.wincent.com/command-t.git'
endfunction

try
        set runtimepath+=~/.vim/bundle/vundle/
        call vundle#rc()
        call LoadBundles()
catch /^Vim\%((\a\+)\)\=:E117/
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

" Reload .vimrc when saved
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWritePost $MYVIMRC call Pl#Load()

" Only show cursorline and colorcolumn in active window
if exists('+cursorline')
        set cursorline
        autocmd WinEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline
endif
if exists('+colorcolumn')
        set colorcolumn=80
        autocmd WinEnter * setlocal colorcolumn=80
        autocmd WinLeave * setlocal colorcolumn=
endif

" Filetype settings
autocmd FileType python setlocal autoindent expandtab shiftwidth=4 softtabstop=4 tabstop=4 cindent cinwords=if,elif,else,for,while,try,except,finally,def,class


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

" Edit .vimrc
nnoremap <leader>. :vsplit $MYVIMRC<CR>

" Open file in vertically split window
nnoremap <leader>o :Sexplore!<CR>

" Fast saving
nnoremap <leader>w :w!<CR>

" Fast help
nnoremap <leader>h :help<Space>

" Fast substitution
nnoremap <leader>s :%s/

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

" Disable search highlighting
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Show syntax highlighting groups for word under cursor
nnoremap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
        if !exists("*synstack")
                return
        endif
        echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Vundle plugin
nnoremap <leader>vbc :BundleClean<CR>
nnoremap <leader>vbi :BundleInstall<CR>
nnoremap <leader>vbl :BundleList<CR>

" Tagbar plugin
let g:tagbar_iconchars = ['▾', '▸']
nnoremap <leader>tt :TagbarToggle<CR>

" CtrlP plugin
nnoremap <leader>ff :CtrlPMixed<CR>

" Swap windows
" http://stackoverflow.com/questions/2586984/how-can-i-swap-positions-of-two-open-files-in-splits-in-vim
function! MarkWindowSwap()
        let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
        "Mark destination
        let curNum = winnr()
        let curBuf = bufnr( "%" )
        exe g:markedWinNum . "wincmd w"
        "Switch to source and shuffle dest->source
        let markedBuf = bufnr( "%" )
        "Hide and open so that we aren't prompted and keep history
        exe 'hide buf' curBuf
        "Switch to dest and shuffle source->dest
        exe curNum . "wincmd w"
        "Hide and open so that we aren't prompted and keep history
        exe 'hide buf' markedBuf
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>


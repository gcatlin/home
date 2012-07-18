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
set grepprg=ack
set hidden
set history=700
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
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
set ttimeoutlen=100
set ttyfast
set visualbell
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
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
        "Bundle 'kana/vim-textobj-function'
        Bundle 'kien/ctrlp.vim'
        Bundle 'majutsushi/tagbar'
        Bundle 'michaeljsmith/vim-indent-object'
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
        "Bundle 'vim_movement'

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
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4 cindent cinwords=if,elif,else,for,while,try,except,finally,def,class

autocmd BufNewFile,BufRead *.go set filetype=go
autocmd FileType go setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mappings
"

" Set the mapleader (default is "\")
let mapleader=","
let g:mapleader=","

" Lazy Escape
inoremap jj <Esc>

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

" Easy omni-completion
inoremap <C-space> <c-x><c-o>

" Maximize window height and set width to something reasonable
nnoremap <C-W>m 85<C-W><Bar><C-W>_
nmap <C-W><C-M> <C-W>m

" Show syntax highlighting groups for word under cursor
nnoremap <C-S-H> :call <SID>SynStack()<CR>
function! <SID>SynStack()
        if !exists("*synstack")
                return
        endif
        echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Swap windows
" http://stackoverflow.com/questions/2586984/how-can-i-swap-positions-of-two-open-files-in-splits-in-vim
function! MarkWindowSwap()
        let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
        "Mark destination
        let curNum = winnr()
        let curBuf = bufnr("%")
        execute g:markedWinNum . "wincmd w"
        "Switch to source and shuffle dest->source
        let markedBuf = bufnr("%")
        "Hide and open so that we aren't prompted and keep history
        execute "hide buf" curBuf
        "Switch to dest and shuffle source->dest
        execute curNum . "wincmd w"
        "Hide and open so that we aren't prompted and keep history
        execute "hide buf" markedBuf
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin mappings and configuration
"

" Vundle plugin
nnoremap <leader>vc :BundleClean<CR>
nnoremap <leader>vi :BundleInstall<CR>
nnoremap <leader>vl :BundleList<CR>
nnoremap <leader>vs :BundleSearch 


" Tagbar plugin
let g:tagbar_iconchars = ['▾', '▸']
nnoremap <leader>tt :TagbarToggle<CR>

" CtrlP plugin
let g:ctrlp_map = '<c-p>'
let g:ctrlp_custom_ignore = {
        \ 'dir':  '\.git$\|\.hg$\|\.svn$',
        \ }
nnoremap <leader>fd :CtrlPDir<CR>
nnoremap <leader>ff :CtrlP<CR>
nnoremap <leader>fl :CtrlPLine<CR>
nnoremap <leader>fq :CtrlPQuickfix<CR>
nnoremap <leader>fr :CtrlPMRU<CR>
nnoremap <leader>fs :CtrlPBufTag<CR>
nnoremap <leader>ft :CtrlPTag<CR>


" vim: set noexpandtab shiftwidth=4 softtabstop=4 tabstop=4:

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

" Remove ALL mappings
mapclear

set autoindent
set backspace=indent,eol,start
set cindent
set completeopt=longest,menuone,preview
set cursorline
set directory=$HOME/.vim/tmp
set encoding=utf-8
set formatoptions=cqrn1
set gdefault
set grepprg=ack\ -a\ -H\ --nocolor\ --nogroup\ --column
set grepformat=%f:%l:%c:%m
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
set shiftround
set showcmd
set showmatch
set smartcase
set smartindent
set smarttab
set tags=./tags;
set textwidth=80
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

	" vim-scripts repos
	Bundle 'Align'

	" GitHub repos
	Bundle 'gcatlin/modokai.vim'
	Bundle 'gcatlin/Pretty-Vim-Python'
	Bundle 'gcatlin/go-vim'
	Bundle 'tomtom/tcomment_vim'
	Bundle 'Lokaltog/vim-powerline'
	Bundle 'Lokaltog/vim-easymotion'
	Bundle 'Valloric/YouCompleteMe'
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

" Autosave
"autocmd FocusLost * :wa

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "normal g`\"" |
			\ endif

" Reload .vimrc when saved
autocmd BufWritePost $MYVIMRC source $MYVIMRC | call Pl#Load()

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

" Set the mapLeader (default is "\")
let mapleader=","
let g:mapleader=","

" Lazy escape
inoremap jj <Esc>

" Oh, F1, how I hate thee
nnoremap <F1> <Esc>
inoremap <F1> <Esc>
vnoremap <F1> <Esc>

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Use real regex syntax when searching
nnoremap / /\v
nnoremap ? ?\v
vnoremap / /\v
vnoremap ? ?\v

" Easy bracket matching
"nnoremap <Tab> %
"vnoremap <Tab> %

" Don't use Ex mode, use Q for formatting
nnoremap Q gq

" Make Y behave like other capitals.
nnoremap Y y$

" Prevent 'x' from appending to register
nnoremap x "_x

" Duplicate a selection
vnoremap D y`>p

" Overwrite Visual mode selection
vnoremap p "_dP

" Prevent highlight being lost on (de)indent
vnoremap < <gv
vnoremap > >gv

" Easy interaction with system pasteboard
nnoremap <Leader>p "*]p
nnoremap <Leader>P "*]P
vnoremap <Leader>p "*]p
vnoremap <Leader>P "*]P
nnoremap <Leader>y "*y
nnoremap <Leader>Y "*Y
vnoremap <Leader>y "*y
vnoremap <Leader>Y "*Y

" Toggles invisible characters
nnoremap <Leader>i :set list!<CR>

" Edit .vimrc
nnoremap <Leader>. :vsplit $MYVIMRC<CR>

" Open file in vertically split window
nnoremap <Leader>o :Sexplore!<CR>

" Easy saving
nnoremap <Leader>s :w!<CR>

" Strip trailing whitespace
nnoremap <leader>S :%s/\s\+$//<CR>:nohlsearch<CR>

" Disable search highlighting
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" Easy omni-completion
inoremap <C-Space> <C-X><C-O>

" Maximize window height and set width to something reasonable
function! ExpandWindow(min_width)
	let cur_width = winwidth(0)
	if cur_width < a:min_width
		execute a:min_width . "wincmd |"
	endif
	execute "wincmd _"
endfunction
nnoremap <silent> <C-W>e :call ExpandWindow(85)<CR>
nnoremap <silent> <C-W><C-E> :call ExpandWindow(85)<CR>

" Easy window navigation
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nnoremap <C-M> :call <SID>SynStack()<CR>

" Swap windows
" http://stackoverflow.com/questions/2586984/how-can-i-swap-positions-of-two-open-files-in-splits-in-vim
function! MarkWindow()
	let g:markedWinNum = winnr()
endfunction

function! SwapBufferWithMarkedWindow()
	" Capture current window and buffer
	let curWinNum = winnr()
	let curBufNum = bufnr("%")

	" Switch to marked window, mark buffer, and open current buffer
	execute g:markedWinNum . "wincmd w"
	let markedBufNum = bufnr("%")
	execute "hide buf" curBufNum

	" Switch back to current window and open marked buffer
	execute curWinNum . "wincmd w"
	execute "hide buf" markedBufNum
endfunction

function! CloseMarkedWindow()
	" Capture current window
	let curWinNum = winnr()

	" Switch to marked window and close it, then switch back to current window
	execute g:markedWinNum . "wincmd w"
	execute "hide close"
	execute "wincmd p"
endfunction

function! MoveWindowLeft()
	call MarkWindow()
	execute "wincmd h"
	if winnr() == g:markedWinNum
		execute "wincmd H"
	else
		let g:markedWinNum += 1
		execute "wincmd s"
		execute g:markedWinNum . "wincmd w"
		execute "wincmd h"
		call SwapBufferWithMarkedWindow()
		call CloseMarkedWindow()
	endif
endfunction

function! MoveWindowDown()
	call MarkWindow()
	execute "wincmd j"
	if winnr() == g:markedWinNum
		execute "wincmd J"
	else
		execute "wincmd v"
		execute g:markedWinNum . "wincmd w"
		execute "wincmd j"
		call SwapBufferWithMarkedWindow()
		call CloseMarkedWindow()
	endif
endfunction

function! MoveWindowUp()
	call MarkWindow()
	execute "wincmd k"
	if winnr() == g:markedWinNum
		execute "wincmd K"
	else
		let g:markedWinNum += 1
		execute "wincmd v"
		execute g:markedWinNum . "wincmd w"
		execute "wincmd k"
		call SwapBufferWithMarkedWindow()
		call CloseMarkedWindow()
	endif
endfunction

function! MoveWindowRight()
	call MarkWindow()
	execute "wincmd l"
	if winnr() == g:markedWinNum
		execute "wincmd L"
	else
		execute "wincmd s"
		execute g:markedWinNum . "wincmd w"
		execute "wincmd l"
		call SwapBufferWithMarkedWindow()
		call CloseMarkedWindow()
	endif
endfunction

nnoremap <silent> <Leader>wm :call MarkWindow()<CR>
nnoremap <silent> <Leader>ws :call SwapBufferWithMarkedWindow()<CR>
nnoremap <silent> <Leader>wh :call MoveWindowLeft()<CR>
nnoremap <silent> <Leader>wj :call MoveWindowDown()<CR>
nnoremap <silent> <Leader>wk :call MoveWindowUp()<CR>
nnoremap <silent> <Leader>wl :call MoveWindowRight()<CR>

" http://stackoverflow.com/a/7321131/1518167
function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction


" Show current class and method (python only)
" http://jeetworks.org/node/147
function! s:get_last_python_class()
	let l:retval = ""
	let l:last_line_declaring_a_class = search('^\s*class', 'bnW')
	let l:last_line_starting_with_a_word_other_than_class = search('^\ \(\<\)\@=\(class\)\@!', 'bnW')
	if l:last_line_starting_with_a_word_other_than_class < l:last_line_declaring_a_class
		let l:nameline = getline(l:last_line_declaring_a_class)
		let l:classend = matchend(l:nameline, '\s*class\s\+')
		let l:classnameend = matchend(l:nameline, '\s*class\s\+[A-Za-z0-9_]\+')
		let l:retval = strpart(l:nameline, l:classend, l:classnameend-l:classend)
	endif
	return l:retval
endfunction

function! s:get_last_python_def()
	let l:retval = ""
	let l:last_line_declaring_a_def = search('^\s*def', 'bnW')
	let l:last_line_starting_with_a_word_other_than_def = search('^\ \(\<\)\@=\(def\)\@!', 'bnW')
	if l:last_line_starting_with_a_word_other_than_def < l:last_line_declaring_a_def
		let l:nameline = getline(l:last_line_declaring_a_def)
		let l:defend = matchend(l:nameline, '\s*def\s\+')
		let l:defnameend = matchend(l:nameline, '\s*def\s\+[A-Za-z0-9_]\+')
		let l:retval = strpart(l:nameline, l:defend, l:defnameend-l:defend)
	endif
	return l:retval
endfunction

function! s:compose_python_location()
	let l:pyloc = s:get_last_python_class()
	if !empty(pyloc)
		let pyloc = pyloc . "."
	endif
	let pyloc = pyloc . s:get_last_python_def()
	return pyloc
endfunction

function! <SID>EchoPythonLocation()
	echo s:compose_python_location()
endfunction

command! PythonLocation :call <SID>EchoPythonLocation()
nnoremap <Leader>? :PythonLocation<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin mappings and configuration
"

" Ack plugin
nnoremap <Leader>a :vsplit<Esc>:Ack 
"nnoremap <Leader>a :botright copen 10<Esc>:grep 

" CtrlP plugin
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_map = '<C-P>'
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\.git$\|\.hg$\|\.svn$',
			\ }
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir',
			\ 'undo', 'line', 'changes', 'mixed']

nnoremap <Leader>fb :CtrlPBuffer<CR>
nnoremap <Leader>fc :CtrlPChange<CR>
nnoremap <Leader>fd :CtrlPDir<CR>
nnoremap <Leader>ff :CtrlP<CR>
nnoremap <Leader>fl :CtrlPLine<CR>
nnoremap <Leader>fq :CtrlPQuickfix<CR>
nnoremap <Leader>fr :CtrlPMRU<CR>
nnoremap <Leader>fs :CtrlPBufTag<CR>
nnoremap <Leader>ft :CtrlPTag<CR>
nnoremap <Leader>fu :CtrlPUndo<CR>

" Tagbar plugin
let g:tagbar_iconchars = ['▾', '▸']
let g:tagbar_autofocus = 1
nnoremap <Leader>tb :TagbarToggle<CR>

" Vundle plugin
nnoremap <Leader>vc :BundleClean<CR>
nnoremap <Leader>vi :BundleInstall<CR>
nnoremap <Leader>vl :BundleList<CR>
nnoremap <Leader>vs :BundleSearch 
nnoremap <Leader>vu :BundleInstall!<CR>


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
set cmdwinheight=10
set commentstring=//\ %s
set completeopt=longest,menuone,preview
set cursorline
set directory=$HOME/.vim/tmp
set encoding=utf-8
set expandtab
set formatoptions=cqrn1
set gdefault
set grepprg=ag\ -a\ -H\ --nocolor\ --nogroup\ --column
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
set shiftwidth=4
set showcmd
"set showmatch
set smartcase
set smartindent
set smarttab
set softtabstop=4
set tabstop=4
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
"    mkdir -p ~/.vim/bundle
"    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"    vim +PluginInstall +qall
" Update with:
"    vim +PluginInstall! +PluginClean +qall

" NOTE: comments after Plugin command are not allowed
function! LoadPlugins()
	call vundle#begin()
	" Required! Lets Vundle manage Vundle
	Plugin 'gmarik/Vundle.vim'

	" vim-scripts repos
	Plugin 'Align'
	Plugin 'paredit.vim'
	Plugin 'taglist.vim'

	" GitHub repos
	Plugin 'bling/vim-airline'
	" Plugin 'ctjhoa/spacevim'
	Plugin 'fatih/vim-go'
	Plugin 'gagoar/StripWhiteSpaces'
	Plugin 'gcatlin/modokai.vim'
	"""Plugin 'gcatlin/Pretty-Vim-Python'
	Plugin 'guns/vim-clojure-static'
	Plugin 'kchmck/vim-coffee-script'
	Plugin 'kien/ctrlp.vim'
	Plugin 'kien/rainbow_parentheses.vim'
	" Plugin 'Lokaltog/vim-powerline'
	Plugin 'Lokaltog/vim-easymotion'
	Plugin 'majutsushi/tagbar'
	Plugin 'plasticboy/vim-markdown'
	Plugin 'racer-rust/vim-racer'
	Plugin 'rking/ag.vim'
	Plugin 'rust-lang/rust.vim'
	" Plugin 'scrooloose/nerdcommenter'
	" Plugin 'scrooloose/nerdtree'
	Plugin 'scrooloose/syntastic'
	Plugin 'sjl/vitality.vim'
	Plugin 'tikhomirov/vim-glsl'
	Plugin 'tpope/vim-abolish'
	Plugin 'tpope/vim-commentary'
	Plugin 'tpope/vim-dispatch'
	Plugin 'tpope/vim-eunuch'
	Plugin 'tpope/vim-fireplace'
	Plugin 'tpope/vim-fugitive'
	Plugin 'tpope/vim-leiningen'
	" Plugin 'tpope/vim-projectionist'
	Plugin 'tpope/vim-repeat'
	Plugin 'tpope/vim-rsi'
	" Plugin 'tpope/vim-salve'
	Plugin 'tpope/vim-surround'
	" Plugin 'Valloric/YouCompleteMe'
	Plugin 'ziglang/zig.vim'

	" Other git repos
	"Plugin 'git://git.wincent.com/command-t.git'
	call vundle#end()
endfunction

" Required!
filetype off
filetype plugin indent off

try
	set runtimepath+=~/.vim/bundle/Vundle.vim
	call LoadPlugins()
catch /^Vim\%((\a\+)\)\=:E117/
	echomsg "Failed to load Vundle. Perhaps Vundle isn't installed?"
	echomsg "To install Vundle: "
	echomsg "  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim"
	echomsg "  vim +PluginInstall +qall"
endtry

" Required!
filetype plugin indent on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fonts, colors and syntax highlighting
"

if &t_Co > 2 || has("gui_running")
	syntax on
	set t_Co=256
	set guifont=Source\ Code\ Pro\ for\ Powerline:h12
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
autocmd BufWritePost $MYVIMRC source $MYVIMRC | call LoadPlugins()

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
autocmd FileType html setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4

autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
autocmd BufRead,BufNewFile *.json setfiletype javascript
command! -range -nargs=0 -bar Jq <line1>,<line2>!jq '.' | jq '.'

autocmd FileType php setlocal expandtab shiftwidth=4 cindent cinwords=if,elseif,else,for,while,try,except,function,class

autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4 cindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" autocmd BufNewFile,BufRead *.go setfiletype go
" autocmd FileType go setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
" autocmd FileType go autocmd BufWritePre <buffer> Fmt
"autocmd FileType go compiler go

autocmd BufRead,BufNewFile *.edn set filetype=clojure

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mappings
"

" Set the mapLeader (default is "\")
let mapleader="\<Space>"
let g:mapleader="\<Space>"

" Join line above below
noremap <silent> <Leader>jk k:join<CR>l
noremap <silent> <Leader>jj :join<CR>

" Lazy escape
"inoremap jk <Esc>
"inoremap jj <Esc>

" Oh, F1, how I hate thee
nnoremap <F1> <Esc>
inoremap <F1> <Esc>
vnoremap <F1> <Esc>

" Disable :only
nnoremap <C-W>o <Nop>
nnoremap <C-W><C-O> <Nop>

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Center cursor after finding next match
nnoremap n nzz

" Use real regex syntax when searching
nnoremap / /\v
nnoremap ? ?\v
vnoremap / /\v
vnoremap ? ?\v

" Search for visual selection
vnoremap // y/<C-R>"<CR>

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
nnoremap <Leader>, :vsplit $MYVIMRC<CR>

" Open file in vertically split window
nnoremap <Leader>o :Sexplore!<CR>

" Easy saving
nnoremap <Leader>ww :w!<CR>

" Strip trailing whitespace
nnoremap <Leader>S :%s/\s\+$//<CR>:nohlsearch<CR>

" Save session (_s_ession _s_ave, _s_ession _l_load)
nnoremap <Leader>ss :mksession! Session.vim<CR>
nnoremap <Leader>sl :source Session.vim<CR>

" Disable search highlighting
" nnoremap <silent> <Esc> <Esc>:nohlsearch<CR>
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" Easy omni-completion
" inoremap <C-Space> <C-X><C-O>

" Enter key will select the highlighted menu item, just as <C-Y> does
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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

" https://superuser.com/questions/382060/shortcut-to-switch-tabs-in-macvim
if has("gui_macvim")
  " Switch to specific tab numbers with Command-number
  noremap <D-1> :tabn 1<CR>
  noremap <D-2> :tabn 2<CR>
  noremap <D-3> :tabn 3<CR>
  noremap <D-4> :tabn 4<CR>
  noremap <D-5> :tabn 5<CR>
  noremap <D-6> :tabn 6<CR>
  noremap <D-7> :tabn 7<CR>
  noremap <D-8> :tabn 8<CR>
  noremap <D-9> :tablast<CR>
endif

" Switch to last-active tab
if !exists('g:Lasttab')
    let g:Lasttab = 1
    let g:Lasttab_backup = 1
endif
autocmd! TabLeave * let g:Lasttab_backup = g:Lasttab | let g:Lasttab = tabpagenr()
autocmd! TabClosed * let g:Lasttab = g:Lasttab_backup
nmap <silent> <Leader><Tab> :exe "tabn " . g:Lasttab<cr>

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
			"bufno exists AND isn't modified AND isn't in the list of
			"buffers open in windows and tabs
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

" Ag plugin
nnoremap <Leader>a :Ag<Space>
"nnoremap <Leader>a :botright copen 10<Esc>:grep

" Airline
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1

" Commentary
au FileType c setlocal commentstring=//\ %s
au FileType cpp setlocal commentstring=//\ %s
au FileType objc setlocal commentstring=//\ %s

" CtrlP plugin
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_map = '<C-P>'
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/](target|\.(git|hg|svn)|node_modules)$',
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

" Paredit
let g:paredit_leader = ','
let g:paredit_smartjump = 1

" Powerline plugin
let g:Powerline_symbols = 'fancy'

" Rainbow Parentheses
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces
highlight! link MatchParen StatusLine
let loaded_matchparen = 1

" Rust
let g:rustfmt_autosave = 1

" Syntastic
let g:syntastic_c_compiler = 'clang'
let g:syntastic_c_compiler_options = ' -std=c11'
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++14 -stdlib=libc++'
let g:syntastic_go_checkers = ['gofmt', 'gotype', 'govet']
let g:syntastic_objc_compiler = 'clang'
let g:syntastic_objc_compiler_options = ' -fmodules'

" Tagbar plugin
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_autofocus = 1
nnoremap <Leader>tb :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" Taglist plugin
let tlist_clojure_settings = 'clojure;f:function'

" vim-go
let g:go_dispatch_enabled = 1
let g:go_fmt_command = "goimports"
" let g:go_highlight_extra_types = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1

au FileType go nmap <Leader>gb <Plug>(go-build)
au FileType go nmap <Leader>gc <Plug>(go-coverage)
au FileType go nmap <Leader>gi <Plug>(go-install)
au FileType go nmap <Leader>gr <Plug>(go-run)
au FileType go nmap <Leader>gt <Plug>(go-test)

au FileType go nmap <Leader>ge <Plug>(go-rename)
au FileType go nmap <Leader>gm <Plug>(go-implements)
au FileType go nmap <Leader>gn <Plug>(go-info)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gdb <Plug>(go-doc-browser)
au FileType go nmap <Leader>gdv <Plug>(go-doc-vertical)

" Vundle plugin
nnoremap <Leader>vc :PluginClean<CR>
nnoremap <Leader>vi :PluginInstall<CR>
nnoremap <Leader>vl :PluginList<CR>
nnoremap <Leader>vs :PluginSearch
nnoremap <Leader>vu :PluginInstall!<CR>

" Zig
let g:zig_fmt_autosave = 1
" let g:zig_fmt_command = ['zig2', 'fmt', '--color', 'off']


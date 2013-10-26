" Maintainer:  Mattia72              Last change: 2013.10.24

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
if has('vim_starting')
  set nocompatible               " Be iMproved
  set runtimepath+=~/.vim/neobundle/neobundle.vim/
endif

" -------------------------------------------------------------------------------
"  NeoBundle
"-------------------------------------------------------------------------------
call neobundle#rc(expand('~/.vim/neobundle/'))
" Let set my bundles not handled by  neobundle
call neobundle#local(expand('~/.vim/bundle/'))
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'L9'
"NeoBundle 'FSwitch'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'bufexplorer.zip'
"NeoBundle 'Gundo' "needs python :( use histwin instead, it needs Vim only.
NeoBundle 'matchit.zip'
"NeoBundleLocal outlookvim
"NeoBundleLocal pentadactyl
NeoBundle 'perl-support.vim'
"NeoBundleLocal publish.zip
NeoBundle 'rainbow_parentheses.vim'
NeoBundle 'msanders/snipmate.vim'
NeoBundle 'surround.vim'
NeoBundle 'taglist.vim'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'abolish.vim'
"NeoBundle 'bitbucket:ns9tks/vim-autocomplpop'   " Needs TortoiseHg :(
"NeoBundle 'othree/vim-autocomplpop'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'FuzzyFinder'
NeoBundle 'PProvost/vim-ps1'
NeoBundle 'vim-signature'
NeoBundle 'chrisbra/histwin.vim'
NeoBundle 'xml.vim'
NeoBundle 'YankRing.vim'

filetype plugin indent on     " Required!

" Installation check.
NeoBundleCheck

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  " horizontal scrollbar
  set guioptions+=bh
else
endif

" WIN-GUI Specials
" first of all: we don't use "behave windows"
" to try to get a better clipboard-handling
" (we do it ourself)
if has("win32")
  "own directory before the others...^= not +=
  set runtimepath^=~\.vim
  set runtimepath+=~\.vim\after
  if has("gui_running")
    " alt jumps to menu
    set winaltkeys=menu
    " set window size
    set lines=40 columns=130
  endif
endif

" set cursor color and blink
function! SetMyGuiCursor()
  set guicursor=
  "hi Cursor gui=reverse guifg=NONE guibg=NONE
  hi Cursor guifg=black guibg=white
  hi iCursor guifg=black guibg=green
  "let &guicursor = substitute(&guicursor, 'n-v-c:', '&blinkon0-', '')
  "let &guicursor = substitute(&guicursor, 'i:', '&ver100-iCursor', '')
  set guicursor+=i:ver100-iCursor
  set guicursor+=n-v-c:blinkon0 "no blinking on normal, visual, command mode
  set guicursor+=i:blinkwait10
endfunction

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    autocmd!

    " Line numbers on the first window
    autocmd BufWinEnter * setlocal rnu "relativenumber
    autocmd BufWinEnter * setlocal nu "number

    " save/load view
    au BufWinLeave ?* silent! mkview
    au BufWinEnter ?* silent! loadview "silent! no error message if there is no file name

    " linenumbers only in active window
    autocmd WinEnter * if bufname('%') != '-MiniBufExplorer-' | setlocal rnu | setlocal nu | endif
    autocmd WinLeave * setlocal nornu
    autocmd WinLeave * setlocal nonu

    " When vimrc is edited, reload it
    autocmd BufWritePost .vimrc source $MYVIMRC

    " Omni Complete
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType c set omnifunc=ccomplete#Complete

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif
    " set cursor color and blink
    autocmd ColorScheme *
          \ call SetMyGuiCursor()
  augroup END
else
  set autoindent   	" always set autoindenting on
endif " has("autocmd")

" DiffOrig
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
   \ | wincmd p | diffthis
endif

"-------------------------------------------------------------------------------
" Colors
"-------------------------------------------------------------------------------
"colors koehler
"colors desert
"colors ir_black
"colors oceanblack
"colors oceandeep
"colors wombat256
"colors underwater
"colors blackboard
"colors molokai
colors my_molokai

" Show syntax highlighting groups for word under cursor: Ctrl Shift P
"nnoremap <C-S-P> :call <SID>SynStack()<CR>
"function! <SID>SynStack()
"if !exists("*synstack")
"return
"endif
"echo noremap(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
"endfunc

"-------------------------------------------------------------------------------
" Settings
"-------------------------------------------------------------------------------
set backspace=indent,eol,start " allow backspacing over everything in insert mode
let &guioptions = substitute(&guioptions, "t", "", "g") "For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
set directory=d:\temp,c:\temp,c:\tmp  "directory for swap files
set textwidth=78 " For all text files set 'textwidth' to 78 characters.
set history=50   "keep 50 lines of command line history
set ruler		 "show the cursor position all the time
set cursorcolumn cursorline "Highlight the screen column of the cursor
set showcmd		 "display incomplete commands
set switchbuf=useopen,usetab
set viewdir=$HOME\.vim\view
set isfname+=32,38 " add space and '&' to filename chars
let g:vimball_home="~/.vim/"
set nowrap
"set showbreak=
set tabstop=2
set shiftwidth=2
set smarttab "a <Tab> in an indent inserts 'shiftwidth' spaces
set shiftround "round to 'shiftwidth' for "<<" and ">>"
set expandtab "expand <Tab> to spaces in Insert mode (local to buffer)
set autoindent "automatically set the indent of a new line (local to buffer)
set autochdir "auto switch to the current file dir
set smartindent "do clever autoindenting (local to buffer)
set cindent "enable specific indenting for C code (local to buffer)
set cinoptions= "options for C-indenting (local to buffer)
set cinkeys=0{,0},0),:,0#,!^F,o,O,e "keys that trigger C-indenting in Insert mode (local to buffer)
set cinwords=if,else,while,do,for,switch "list of words that cause more C-indent (local to buffer)
set indentexpr=GetVimIndent() "expression used to obtain the indent of a line (local to buffer)
set indentkeys=0{,0},:,0#,!^F,o,O,e,=end,=else,=cat,=fina,=END,0\\ "keys that trigger indenting with 'indentexpr' in Insert mode (local to buffer)
set copyindent "Copy whitespace for indenting from previous line (local to buffer)
set preserveindent "Preserve kind of whitespace when changing indent (local to buffer)
set bufhidden=hide "This option specifies what happens when a buffer is no longer displayed in a window:
"put in autocmd section
"set relativenumber "Show the line number relative to the line with the cursor, but not for minibufexplorer...
"set number         "Show the line number
set visualbell " instead of beep on error...
"set foldmethod=syntax
"set foldcolumn=1
set incsearch	    "do incremental searching
set ignorecase
set smartcase
set virtualedit=all
set formatoptions=tcqronl
set laststatus=2   " Always show the statusline
set scrolloff=5
" set grep path, but... i cann't set any options e.g. -nH
" so i use the default findstr
set grepprg=d:\cygwin\bin\grep.exe
call SetMyGuiCursor() " set cursor color and blink
set path+=.  " path to use gf - jump to file.
set suffixesadd=.pm,.pl
set wildmenu
set wildmode=full

"-------------------------------------------------------------------------------
" Mappings ...
"-------------------------------------------------------------------------------
"show highlighting groups
"map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" Don't use Ex mode, use Q for formatting
noremap Q gq
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" With a noremap leader it's possible to do extra key combinations
let mapleader = ","
let g:mapleader = ","
" Most recent file list
nnoremap <F3> :FufMruFile<cr>
" Copy path or file name to clipboard
nnoremap <leader>cp :CopyPath<cr>
nnoremap <leader>cf :CopyFileName<cr>
" Fast saving
"nnoremap <leader>s :w!<cr>
" Window operation
nnoremap <leader>w <C-W>
" Diff jumps
nnoremap <leader>dp [c
nnoremap <leader>dn ]c
" Spell jumps: next previous error
nnoremap <leader>sp [s
nnoremap <leader>sn ]s
" Fast editing of the .vimrc
noremap <leader>e :tabnew! ~\.vimrc<cr>
" jump to tag
nnoremap <leader>j <C-]>
" find word under cursor in the current directory
nnoremap <leader>vg <ESC>:vimgrep <C-R><C-W> *.
" search replace selected whole word
nnoremap <leader>srw <ESC>:%s/\<<C-R><C-W>\>//g<Left><Left><BackSpace>/
" search replace selected word
nnoremap <leader>sr <ESC>:%s/<C-R><C-W>//g<Left><Left><BackSpace>/
" search replace selected
vnoremap <leader>sr y<ESC>:%s/<C-R>0//g<Left><Left><BackSpace>/
"reload syntax
nnoremap <leader>sy :syn on
" habit: edit for other editors
nnoremap <leader>eo :set tw=0 wrap linebreak
" find form name in forms xml
"nnoremap <leader>vf <ESC>:vimgrep <C-R><C-W>  ../**/*.inc ../**/*.ddl ../**/*.mdd
" Clear search highlight
nnoremap <leader><space> :noh<cr>
" Folding...
nnoremap <leader>fs :call <SID>MyFoldSyntax()<cr>
function! <SID>MyFoldSyntax()
  set foldmethod=syntax
  set foldcolumn=1
  set foldlevel=1
endfunction
nnoremap <leader>fm :set foldmethod=manual<cr>
" foldlevel increase/decrease
nnoremap <leader>fi :set foldlevel-=1<cr>
nnoremap <leader>fd :set foldlevel+=1<cr>
nnoremap <leader>fc :call <SID>MyFoldColumn()<cr>
function! <SID>MyFoldColumn()
  if &foldcolumn > 0
    set foldcolumn=0
  else
    set foldcolumn=1
  endif
endfunction
" load all file from quickfix window
nnoremap <leader>lq :cfirst <bar> while 1 <bar> cnext <bar> endwhile <cr>
" close a buffer
nnoremap <leader>bd :bdelete <cr>
" close all buffer
nnoremap <leader>bda :bufdo bdelete <cr>
" Tab navigation like firefox
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab> :tabnext<CR>
noremap <C-S-tab> :tabprevious<CR>
noremap <C-tab> :tabnext<CR>
inoremap <C-S-tab> <esc>:tabprevious<CR>i
inoremap <C-tab> <esc>:tabnext<CR>i
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <esc>:tabnew<CR>
"nnoremap <F3> n
"nnoremap <S-F3> N
" Command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
" Move up/down single line with Ctrl+Arrow
nnoremap <C-Up> [e
nnoremap <C-Down> ]e
" Move up/down multiple lines with Ctrl+Arrow
vnoremap <C-Up> [egv
vnoremap <C-Down> ]egv
" Visually select the text that was last
" edited/pasted
nnoremap gV `[v`]

" autocomplete parenthesis, (brackets) and braces
inoremap  (  ()<Left>
inoremap  [  []<Left>
inoremap  {  {}<Left>
" surround selected text
vnoremap  (  s()<Esc>P<Right>%
vnoremap  [  s[]<Esc>P<Right>%
vnoremap  {  s{}<Esc>P<Right>%

"-------------------------------------------------------------------------------
" Plugins
"-------------------------------------------------------------------------------

"snipMate
let g:snippets_dir="~/.vim/snippets/"

" Helptags should be rebuild if doc changed
nnoremap <leader>ht :Helptags<CR>
" help word under cursor
nnoremap <leader>hh K
" Matchit
source ~/.vim/neobundle/matchit.zip/plugin/matchit.vim
" NerdTree (file tree)
nnoremap <leader>ft :NERDTreeToggle<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
" Histwin (undo tree)
nnoremap <leader>ut :Histwin<CR>
" Nerd commenter for mdd
"let NERD_mdd_alt_style=1
" YankRing
nnoremap <leader>yr :YRShow<CR>
nnoremap <silent> <F11> :YRShow<CR>
" Rainbow braces highlight
nnoremap <leader>rp :RainbowParenthesesToggle<CR>
nnoremap <leader>be :BufExplorer<CR>
let g:bufExplorerSortBy = "mru"
" autocomplpop
let g:acp_behaviorSnipmateLength=1
let g:acp_behaviorKeywordLength = 2
" This is for taglist
let Tlist_Inc_Winwidth = 0
nnoremap <leader>tl :Tlist<CR>
" Fuzzy finder
let g:fuf_dataDir = '~/.vim/data/fuf-data'
let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 500
let g:fuf_mrucmd_maxItem = 500
let g:yankring_history_file = 'yankring_history_file'
let g:yankring_history_dir = '~/.vim/data'
let g:outlook_use_tabs = 1
"XML
let g:xml_syntax_folding = 1
"For Airline
set encoding=utf8
set guifont=Ubuntu\ Mono\ for\ Powerline:h12:cEASTEUROPE
"set guifont=Consolas\ for\ Powerline\ FixedD:h11:cEASTEUROPE
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" old vim-powerline symbols
let g:airline_left_sep = '»'
let g:airline_right_sep = '«'
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.whitespace = 'Ξ'

" EasyMotion
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

" vim:tw=78:ts=4:ft=vim:norl:

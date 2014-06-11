" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.

" Source a global configuration file if available
runtime! archlinux.vim

if filereadable("/etc/vim/vimrc.local")
   source /etc/vim/vimrc.local
endif

" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>		"+gP
map <S-Insert>		"+gP

"source $VIMRUNTIME/mswin.vim
"behave mswin
"set keymodel-=stopsel

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
set nocompatible

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
   syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
   filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set autochdir		" Pone siempre el directorio donde se trabaja
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
set mouse=a			" Enable mouse usage (all modes)
set novisualbell	" Quita la campanita
set title			" Muestra los titulos en cada buffer
map <F12> :set nu!<CR>
					"Muestra los números de línea, nonu lo contrario
set ruler 			"Información de estado
"set cursorline 	"Resalta línea
":hi CursorLine   cterm=NONE ctermbg=green ctermfg=white guibg=darkred guifg=white

" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

"ExtraEspacios
"Con F5 muestras los espacios en blanco, y con F6 los borras
highlight ExtraWhitespace ctermbg=red guibg=red
map <F5> :match ExtraWhitespace /\s\+$/<CR>
map <F6> :%s/\s\+$//e <CR>

"Indentacion
set tabstop=4 	 "Tamano tabulacion
set shiftwidth=4 "Tamano autoindentar

"Latex
au FileType tex setlocal spell spelllang=es
"Html
au FileType html setlocal shiftwidth=2 tabstop=2
"Gzip
augroup gzip
	autocmd!
	autocmd BufReadPre,FileReadPre	*.gz set bin
    autocmd BufReadPost,FileReadPost	*.gz '[,']!gunzip
    autocmd BufReadPost,FileReadPost	*.gz set nobin
    autocmd BufReadPost,FileReadPost	*.gz execute ":doautocmd BufReadPost " . expand("%:r")
    autocmd BufWritePost,FileWritePost	*.gz !mv <afile> <afile>:r
    autocmd BufWritePost,FileWritePost	*.gz !gzip <afile>:r

    autocmd FileAppendPre		*.gz !gunzip <afile>
    autocmd FileAppendPre		*.gz !mv <afile>:r <afile>
    autocmd FileAppendPost		*.gz !mv <afile> <afile>:r
    autocmd FileAppendPost		*.gz !gzip <afile>:r
augroup END
"Python"
au FileType python setlocal expandtab textwidth=79 tabstop=8 softtabstop=4 shiftwidth=4

map <F7> gg=G

"Buffers
map <F2> :previous<CR>  " map F1 to open previous buffer
map <F3> :next<CR>      " map F2 to open next buffer

"Busquedas
set hlsearch "ilumina las búsquedas
map <F8> :nohlsearch <CR>

"Tabs
set showtabline=1

"Folding
set nofen
set foldmethod=indent
set foldminlines=20
map <F4> :set invfen<CR>

"Completar
"set ofu=syntaxcomplete#Complete
set ofu=ccomplete#Complete
set tags+=~/.vim/systags

"Para llamar a la ayuda
" :he algo
"

if has("gui_running")
	set guifont=Inconsolata\ Medium\ 12
endif

set numberwidth=4   " line numbering takes up 5 spaces
set nowrap          " stop lines from wrapping

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

"Syntatic
let g:syntastic_check_on_open=1
let g:pymode_indent = 1
map <C-n> :NERDTreeToggle<CR>

"Python
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

"Airline
set laststatus=2

set bg=dark
"color codeschool
"color desert256
color wombat256mod
"color solarized
"highlight Normal ctermbg=None

"JavaScript
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
let g:syntastic_javascript_checkers = ['gjslint']
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4 expandtab

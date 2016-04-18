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
" runtime! archlinux.vim
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
"Colorschemes http://www.vimninjas.com/2012/08/26/10-vim-color-schemes-you-need-to-own/
"Plugin 'flazz/vim-colorschemes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'nanotech/jellybeans.vim'
Plugin 'vim-scripts/wombat256.vim'
Plugin 'morhetz/gruvbox'
"Plugin 'dsolstad/vim-wombat256i'
"Plugin 'zeis/vim-kolor'
"Git integration
Plugin 'tpope/vim-fugitive'
"Control + P search
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'airblade/vim-rooter'
"Silver searcher
Plugin 'rking/ag.vim'
"Auto Pair () []
Plugin 'Raimondi/delimitMate'
"Vdebug
Plugin 'joonty/vdebug'
"Django
Plugin 'lambdalisue/vim-django-support'
"Ctags Cscope
Plugin 'steffanc/cscopemaps.vim'
"Scala
Plugin 'derekwyatt/vim-scala'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on

"if filereadable("/etc/vim/vimrc.local")
"    source /etc/vim/vimrc.local
"endif

" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","

"Backup and SWP dirs
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
"vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>		"+gP
"map <S-Insert>		"+gP

"source $VIMRUNTIME/mswin.vim
"behave mswin
"set keymodel-=stopsel

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
    syntax on
endif

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
" Emacs end of line
map <c-a> ^
map <c-e> $

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
"set autochdir		" Pone siempre el directorio donde se trabaja
set ignorecase		" Do case insensitive matching
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
"noremap <C-m> :nohl<CR>
"vnoremap <C-m> :nohl<CR>
"inoremap <C-m> :nohl<CR>

"Indentacion
set tabstop=4 	 "Tamano tabulacion
set shiftwidth=4 "Tamano autoindentar
set softtabstop=4
set noexpandtab

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

setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
"Php"
au FileType php let g:vdebug_options['server'] = "10.0.1.79"

"Python"
au FileType python setlocal expandtab textwidth=79 tabstop=8 softtabstop=4 shiftwidth=4
au FileType python map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

"JavaScript
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4 expandtab

"Buffers
"map F1 to open previous buffer
map <F2> :previous<CR>
"map F2 to open next buffer
map <F3> :next<CR>

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
"set tags+=~/.vim/systags
set tags+=./tags;

"Themes and font
set bg=dark

"highlight Normal ctermbg=None

if has("gui_running")
    "set guifont=Inconsolata\ Medium\ 12
    set anti enc=utf-8
    "set guifont=Liberation\ Mono\ 10
    "set guifont=Source\ Code\ Pro\ Semi-Bold\ 11
    set guifont=Inconsolata\ for\ Powerline\ 12
endif

"ExtraEspacios
"Con F5 muestras los espacios en blanco, y con F6 los borras
highlight ExtraWhitespace ctermbg=red guibg=red
map <F5> :match ExtraWhitespace /\s\+$/<CR>
map <F6> :%s/\s\+$//e <CR>

set numberwidth=4   " line numbering takes up 5 spaces
set nowrap          " stop lines from wrapping


"Colors
"color codeschool
"color desert256
"color solarized
"color wombat256mod
color jellybeans

"Syntatic
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:pymode_indent = 1
let g:syntastic_javascript_gjslint_args = "--max_line_length 300"
let g:syntastic_javascript_checkers = ['gjslint']
"Scala
let g:syntastic_ignore_files = ['\m\c\.h$', '\m\.sbt$']

" Scala has fsc and scalac checkers--running both is pretty redundant and
" " slow. An explicit `:SyntasticCheck scalac` can always run the other.
let g:syntastic_scala_checkers = ['fsc']

"YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

"NERDTree
map <C-n> :NERDTreeToggle<CR>

"Airline
set laststatus=2
let g:airline_powerline_fonts = 1

"TagBar
nmap <F7> :TagbarToggle<CR>

"ControlP Fuzzy
set runtimepath^=~/.vim/bundle/ctrlp.vim
nnoremap <leader>b :CtrlPBuffer<CR>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
nnoremap <leader>/ :Ag -i<space>
map K :Ag -i "<cword>"<CR>

if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" ALT + ] -> Open the definition in a vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"Syntastic colors
hi SpellBad	guifg=NONE	guibg=NONE	guisp=#c03000
hi SpellCap	guifg=NONE	guibg=NONE	guisp=#2060a8

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
"Colors
Plug 'chriskempson/base16-vim'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'lifepillar/vim-gruvbox8'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf.vim'
"Completion
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
"Close autocomplete window
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"Syntax check with ALE(async)
Plug 'w0rp/ale'
"Multiple syntax files
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-rooter'
"Powerline
Plug 'itchyny/lightline.vim'
"Git
Plug 'tpope/vim-fugitive'
"Comment out a line -> <leader>cc, un-comment -> <leader>cu
Plug 'scrooloose/nerdcommenter'
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
call plug#end()

set termguicolors
colorscheme Tomorrow-Night

"Ignore virtualenvs
let g:python3_host_prog = '/usr/bin/python3'
let mapleader = "\<Space>"

"FZF Control + P 
nnoremap <C-p> :Files<Cr>

"NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

"Trailing spaces
"F5 shows blank spaces, F6 deletes them
highlight ExtraWhitespace ctermbg=red guibg=red
map <F5> :match ExtraWhitespace /\s\+$/<CR>
map <F6> :%s/\s\+$//e <CR>

"colorscheme wombat
"
"Copy and Paste to/from Clipboard with leader key
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Spaces & Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent or '>'
set expandtab       " Pressing TAB = softtabstop SPACEs
set smartindent     " Enables autoindent too
" }}} Spaces & Tabs

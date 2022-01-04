set encoding=utf-8
let mapleader=','

syntax on

set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
autocmd FileType make set noexpandtab " makefile 不需要扩展
autocmd FileType cpp,html,css,xml,yaml,json set sw=2 ts=2

set nu
set foldmethod=syntax
set nofoldenable
set mouse=a

set laststatus=2 " show status line

set backspace=2
" set colorcolumn=80
set cursorline

set ignorecase
set incsearch
set hlsearch
set smartcase

set linebreak

set wildignore+=*.swp
set nocompatible

filetype on
filetype plugin on
filetype indent on
set autoindent
set smartindent
set shiftround

set fileencodings=ucs-bom,utf-8,cp936,gb18030,gb2312,big5,euc-jp,euc-kr,latin1

set synmaxcol=600

set scrolloff=3

" keybinding begin -------------

imap jk <ESC>

nnoremap <leader>sp :split<CR>
nnoremap <leader>vs :vsplit<CR>
nnoremap <leader>st :tab split<CR>

noremap \ ,

for s:i in range(1, 9)
    execute 'nnoremap <leader>' . s:i . ' ' . s:i . 'gt'
endfor

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" keybinding end ---------------


let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='wombat'
let g:airline_powerline_fonts=1

" plugin begin -----------------------
call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/vim-airline'

call plug#end()
" plugin end -------------------------


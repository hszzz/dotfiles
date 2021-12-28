" ------------ general settings ------------

set nocompatible
set encoding=utf-8

syntax on
syntax enable
set nu
set foldmethod=syntax
set nofoldenable
set mouse=a

set backspace=2     " 删除键的问题
" set colorcolumn=80  " max line 80
" set cursorline      " 高亮光标所在行

" search
set ignorecase
set incsearch
set hlsearch
set smartcase

set linebreak
filetype on
filetype plugin on
filetype indent on
set autoindent
set smartindent
set shiftround

set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1 " 打开文件尝试编码顺序
let mapleader=','

" ------------------------------------------

" ---------- global key binding ------------
" export MYVIMRC=".vimrc"

inoremap jk <esc>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>      " 快速修改 .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>      " 快速生效 .vimrc
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel " 快速给单词加 ""

nnoremap <leader>sp :split<CR>
nnoremap <leader>vs :vsplit<CR>
nnoremap <leader>st :tab split<CR>

" ,作为了leader key, 将\映射成反向查找
noremap \ ,

" use q to exit help window
autocmd FileType help noremap <buffer> q :q<cr>

" tab 间移动
for s:i in range(1, 9)
  execute 'nnoremap <Leader>' . s:i . ' ' . s:i . 'gt'
endfor

nnoremap <Leader>tc :tabc<CR>
nnoremap <Leader>tn :tabn<CR>
nnoremap <Leader>tp :tabp<CR>
nnoremap <Leader>te :tabe<Space>

" 窗口间移动
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ------------------------------------------

" ------ space or tab setting --------------

set tabstop=4
set shiftwidth=4   " 默认用 4 个空格
set autoindent     " 自动缩进
set expandtab      " tab 键永远输入的是空格
set softtabstop=0  " 关闭33 softtabstop 永远不要将空格和 tab 混合输入

autocmd FileType make set noexpandtab " makefile 不需要扩展

" 特定的文件 tab 设置为 2
autocmd FileType cpp,html,css,xml,yaml,json set sw=2 ts=2

" ------------------------------------------


" ------------- abbreviation ---------------

iabbrev @@ hszzz dot me at gmail dot com

" ------------------------------------------

" --------------- autocmd ------------------

autocmd BufNewFile * :write " 打开新文件自动保存

" 打开文件或者写入html文件的时候，先格式化
autocmd BufWritePre,BufRead *.html :normal gg=G
" 打开或者写入html文件的时候，设置nowrap
autocmd BufNewFile,BufRead *.html setlocal nowrap
autocmd FileType cpp iabbrev <buffer> iff if ()<left>

" plugin begin -----------------------
call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/vim-airline'

call plug#end()
" plugin end -------------------------


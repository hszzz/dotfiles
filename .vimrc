
" install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set encoding=utf-8
let mapleader=','

syntax on

" tab
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

set termguicolors

" shutdown beep
set vb t_vb=

" keybinding
imap jk <ESC>
" nnoremap <leader>sp :split<CR>
" nnoremap <leader>vs :vsplit<CR>
" nnoremap <leader>st :tab split<CR>

noremap \ ,

for s:i in range(1, 9)
    execute 'nnoremap <leader>' . s:i . ' ' . s:i . 'gt'
endfor

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='wombat'
let g:airline_powerline_fonts=1

" ycm
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_error_symbol='✗'
let g:ycm_warning_symbol='⚠'
let g:ycm_filetype_whitelist = {"c": 1, "cpp": 1, "python": 1}
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_key_invoke_completion = '<c-z>'

let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 1

nnoremap <leader><leader> :YcmCompleter GoTo<CR>
nnoremap <leader>[ :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>d :YcmCompleter GetDoc<CR>
nnoremap <leader>r :YcmCompleter RefactorRename<SPACE>
nnoremap <leader>f :YcmCompleter FixIt<CR>1
nnoremap <leader>y :call ToggleYcmDiagnostics()<CR><CR>:wa<CR>:e<CR>

func! ToggleYcmDiagnostics()
    let g:ycm_show_diagnostics_ui = !g:ycm_show_diagnostics_ui
    YcmRestartServer
endfunc

" ultisnips
" let g:UltiSnipsExpandTrigger='<c-s>'
" let g:UltiSnipsJumpForwardTrigger='<tab>'
" let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
" let g:UltiSnipsEditSplit='vertical'

" cmake4vim
let g:cmake_build_type = 'Debug'
let g:cmake_compile_commands = 1
" let g:cmake_build_path_pattern = ["/tmp/build/%s", "getcwd()"]
nnoremap <leader>cmst :CMakeSelectTarget<space>
nnoremap <leader>cmi :CMakeInfo<CR>
nnoremap <leader>cmrun :CMakeRun<CR>
nnoremap <leader>cmake :CMake<CR>:CMakeBuild<CR>
nnoremap <F7> :CMake<CR>:CMakeBuild<CR>
nnoremap <F8> :CMakeRun<CR>

" scheme: NeoSolarized
colorscheme NeoSolarized
set background=dark " dark version

" formatter
" sudo apt install clang-format
autocmd FileType c,cpp setlocal equalprg=clang-format " gg=G use clang-format
noremap <F3> :Autoformat<CR>
au BufWrite * :Autoformat<CR>

" plugin
call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/vim-airline'
Plug 'ycm-core/YouCompleteMe', {'do': './install.py --clang-completer'}
Plug 'preservim/nerdtree'
Plug 'ilyachur/cmake4vim'
Plug 'overcache/NeoSolarized' " theme
Plug 'Chiel92/vim-autoformat'

" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
call plug#end()


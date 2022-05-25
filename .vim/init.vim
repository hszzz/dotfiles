" install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let mapleader='g'

set nocompatible
set encoding=utf-8
set et ts=4 sts=4 sw=4
set fdm=syntax fdl=100
set nu ru ls=2
set hls is si
set cinoptions=j1,(0,ws,Ws,g0
set formatoptions-=cro
set timeout nottimeout ttimeoutlen=10
set mouse=a
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
set showbreak=↪
set list
set cursorline
set vb t_vb=

set undofile
set undofile
if has('nvim')
    set undodir=/tmp/nvim//,.
    set backupdir=/tmp/nvim//,.
    set directory=/tmp/nvim//,.
else
    set undodir=/tmp//,.
    set backupdir=/tmp//,.
    set directory=/tmp//,.
endif

autocmd FileType make set noexpandtab
autocmd FileType cpp,html,css,xml,yaml,json set sw=2 ts=2

autocmd SwapExists * let v:swapchoice = 'e'
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

nnoremap Q :wa!<CR>:qa!<CR>

nnoremap <F5> :AsyncTasks project-build project-run<CR>
nnoremap <F6> :AsyncTask project-build<CR>
nnoremap <F7> :AsyncTasks file-build file-run<CR>
nnoremap <silent> <F9> :wa<CR>:NERDTreeToggle<CR><C-w>l:Vista!!<CR><C-w>h

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" {{{ theme
let g:one_allow_italics = 1
set termguicolors
set background=dark
colorscheme one
" }}} theme

" {{{ airline
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#keymap#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
" let g:airline_powerline_fonts = 1
let g:airline_theme = 'one'

nmap <silent> <leader>1 <Plug>AirlineSelectTab1
nmap <silent> <leader>2 <Plug>AirlineSelectTab2
nmap <silent> <leader>3 <Plug>AirlineSelectTab3
nmap <silent> <leader>4 <Plug>AirlineSelectTab4
nmap <silent> <leader>5 <Plug>AirlineSelectTab5
nmap <silent> <leader>6 <Plug>AirlineSelectTab6
nmap <silent> <leader>7 <Plug>AirlineSelectTab7
nmap <silent> <leader>8 <Plug>AirlineSelectTab8
nmap <silent> <leader>9 <Plug>AirlineSelectTab9

nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
" }}} airline

" {{{ coc.nvim
set nohidden
set nobackup
set nowritebackup
set updatetime=300
set cmdheight=1
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>D <Plug>(coc-type-definition)
nmap <silent> <leader>c <Plug>(coc-declaration)
nmap <silent> <leader>C <Plug>(coc-implementation)
nmap <silent> <leader>r <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>R <Plug>(coc-rename)

" Formatting selected code.
command! -nargs=0 Format    :call CocActionAsync('format')
xmap <leader>q <Plug>(coc-format-selected)
" nmap <leader>q <Plug>(coc-format-selected)
nnoremap <leader>q :Format<CR>

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold      :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OrgImport :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" }}} coc.nvim

" {{{ coc.snippets
let g:coc_snippet_next = '<tab>'
" }}} coc.snippets

" {{{ asynctasks
let g:asyncrun_open = 6
let g:asynctasks_term_pos = 'floaterm_reuse'
let g:asynctasks_term_rows = 6
let g:asynctasks_term_cols = 50
let g:asynctasks_term_reuse = 1
let g:asynctasks_term_focus = 0
let g:asyncrun_rootmarks = ['.tasks', '.git/']

function! AsyncTaskMultiple(first, ...)
    if len(a:000) >= 1
        if a:first == 0
            cclose
        endif
        let l:tmp = ""
        for task in a:000[1:]
            let l:tmp .= "'".l:task."',"
        endfor
        let l:tmp = l:tmp[:-1]
        let g:asyncrun_exit = "if g:asyncrun_code == 0 | call AsyncTaskMultiple(0, ".l:tmp.") | else | call AsyncTaskMultiple(0) | endif"
        exec "AsyncTask ".a:000[0]
    else
        let g:asyncrun_exit = ""
    endif
endfunction
command! -nargs=+ AsyncTasks   :call AsyncTaskMultiple(1, <f-args>)
" }}} asynctasks

" {{{ vim-floaterm
let g:floaterm_wintype = 'split'
let g:floaterm_position = 'botright'
let g:floaterm_height = 12
let g:floaterm_keymap_toggle = '<C-t>'
" }}} vim-floaterm

" {{{ LeaderF
let g:Lf_ShowDevIcons  = 0
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewCode = 1

let g:Lf_ShortcutF = "<leader>ff"

noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>fx :<C-U><C-R>=printf("Leaderf command %s", "")<CR><CR>
noremap <leader>f: :<C-U><C-R>=printf("Leaderf cmdHistory %s", "")<CR><CR>
noremap <leader>f/ :<C-U><C-R>=printf("Leaderf searchHistory %s", "")<CR><CR>
noremap <leader>fw :<C-U><C-R>=printf("Leaderf window %s", "")<CR><CR>
noremap <leader>fj :<C-U><C-R>=printf("Leaderf jumps %s", "")<CR><CR>

noremap <leader>fi :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s", expand("<cword>"))<CR><CR>
noremap <leader>fa :<C-U><C-R>=printf("Leaderf! rg -e %s", expand("<cword>"))<CR><CR>
xnoremap <leader>fi :<C-U><C-R>=printf("Leaderf! rg --current-buffer -F -e %s", leaderf#Rg#visual())<CR><CR>
xnoremap <leader>fa :<C-U><C-R>=printf("Leaderf! rg -F -e %s", leaderf#Rg#visual())<CR><CR>
noremap <leader>fr :<C-U>Leaderf! rg --recall<CR>
" }}} LeaderF

" {{{ Vista
let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 0
" let g:vista#renderer#icons = {
" \   "function": "\uf794",
" \   "variable": "\uf71b",
" \  }
" }}} Vista

" plugin
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rakr/vim-one'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'voldikss/vim-floaterm'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'liuchengxu/vista.vim' ", {'on': 'Vista!!'}
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
call plug#end()

if filereadable(".vim_localrc")
    source .vim_localrc
endif


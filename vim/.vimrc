" {{{ Minpac
" Try to load minpac.

function! InitPack() abort
    packadd minpac

    call minpac#init()
    call minpac#add('lifepillar/vim-solarized8') "Solarized colours
    call minpac#add('sheerun/vim-polyglot') "Language Support
    call minpac#add('tpope/vim-fugitive') "Git support
    call minpac#add('SirVer/ultisnips') "Snippets 
    call minpac#add('mbbill/undotree') " Undo tree of changes
    " Fuzzy Find
    call minpac#add('ctrlpvim/ctrlp.vim')
    call minpac#add('junegunn/fzf')
    call minpac#add('junegunn/fzf.vim')

    call minpac#add('prabirshrestha/async.vim') " Jobs between Vim/NeoVim for Vim LSP
    call minpac#add('prabirshrestha/vim-lsp') " Language Server protocol
    call minpac#add('thomasfaingnaert/vim-lsp-ultisnips') " UltiSnips for Language Server protocol

endfunction

" Define user commands for updating/cleaning the packages
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackClean   call InitPack() | call minpac#clean()
command! PackSetup   call InitPack() | call minpac#update('', { 'do': 'quit! | quit!' })
command! PackStatus  call InitPack() | call minpac#status()
command! PackUpdate  call InitPack() | call minpac#update('', { 'do': 'call minpac#status() | quit! | quit!' })

packloadall "Load all packages
" }}}

" {{{ Language Server Packs
if executable('pyls')
    " pip install python-language-server[all]
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
" }}}

" Colors {{{
let g:solarized_termtrans = 1 "Terminal setting for colours
colorscheme solarized8_high "Pretty colours
set bg=dark "Dark background
" }}}

" Basics {{{
filetype plugin indent on " Add ft, plugin & indent support
syntax on "Turn on syntax highlighting
let mapleader = "\<Space>" "Set the leader key
set relativenumber "Relative line numbers
set path=**
set noswapfile "Don't use a swap file
set hidden "Allow switching buffers without writing to disk
set wildignore+=**/venv/**,*.pyv,*.pyo,__pycache__
set listchars=tab:▸\ ,eol:¬
set foldlevel=1
set hlsearch " highlight search matches
set incsearch " start incremental search
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
      \ 'file': '\.pyc$\|\.pyo$',
      \ }
let g:netrw_banner = 0 "No header for netrw directory mode
let g:netrw_liststyle = 3 "Tree style dir listings
let g:netrw_browse_split = 2 " Vertically split netrw
let g:netrw_winsize = 20 "Netrw window size
set shell=/bin/bash
set tags=$PWD/.git/tags
let g:fzf_tags_command = "git ctags"
"}}}

" Spacing {{{
set foldmethod=marker " Group folds with '{{{,}}}'
set expandtab "Don't use tab charachter use spaces
set shiftwidth=2 "Indenting is 4 spaces
set softtabstop=2 "Number of spaces when pressing tab
"}}}

" Mappings {{{
" Normal Mode Mappings
nmap <Leader>b :CtrlPBuffer<CR>
"Switch to last used buffer, map to CTRL-E
nmap <Leader>e :e#<CR> 
nmap <Leader>f :CtrlP<CR>
nmap <Leader>t :CtrlPTag<CR>
nmap <Leader>h :CtrlPMRUFiles<CR>
nmap <Leader>l :Lex<CR>
"Go to next/prev buffer
nmap <Leader>n :bnext<CR>
nmap <Leader>p :bprev<CR>
nmap <Leader>u :UndotreeToggle<CR>
" Toggle Whitespace
nmap <Leader>w :set list!<CR>

"" Git fugitive plugin mappings
map <Leader>ga :Git add %<cr>
map <Leader>gc :Git commit<cr>
map <Leader>gd :Git diff<cr>
map <Leader>gg :Git<cr>
map <Leader>gp :Git push<cr>
map <Leader>gr :Git checkout %<cr>
map <Leader>gs :Git status<cr>

" Insert Mode Mappings
inoremap kj <Esc>
inoremap jj <Esc>

" Visual Mode Mappings
vnoremap <Leader>Y \+y
" }}}

" Autocommands {{{
if has("autocmd")
    " Uncomment the following to have Vim jump to the last position when reopening a file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g`\"" | endif
    " resize windows equally on viewport change
    autocmd VimResized * wincmd = 
    " Source vimrc when changed
    autocmd! bufwritepost vimrc source %
endif
"}}}

" Snippets {{{
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" }}}

" Search {{{
" External program to use for grep command
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat=%f:%l:%c:%m
endif
"}}}

" Store undo {{{
if has("persistent_undo")
   let target_path = expand('~/.vim/undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif
" }}}

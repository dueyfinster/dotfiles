" {{{ Minpac
" Try to load minpac.
silent! packadd minpac

if !exists('*minpac#init')
  " No plugins are available
  finish
else
  call minpac#init()
  call minpac#add('lifepillar/vim-solarized8') "Solarized colours
  call minpac#add('sheerun/vim-polyglot') "Language Support
  call minpac#add('SirVer/ultisnips') "Snippets 
  call minpac#add('ctrlpvim/ctrlp.vim')

  call minpac#add('prabirshrestha/async.vim') " Jobs between Vim/NeoVim for Vim LSP
  call minpac#add('prabirshrestha/vim-lsp') " Language Server protocol
  call minpac#add('thomasfaingnaert/vim-lsp-ultisnips') " UltiSnips for Language Server protocol
endif

" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
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
set shiftwidth=4 "Indenting is 4 spaces
set softtabstop=2 "Number of spaces when pressing tab
"}}}

" Mappings {{{
" Normal Mode Mappings
nmap <Leader>b :CtrlPBuffer<CR>
nmap <Leader>f :CtrlP<CR>
nmap <Leader>t :CtrlPTag<CR>
nmap <Leader>h :CtrlPMRUFiles<CR>
nmap <Leader>l :Lex<CR>
" Toggle Whitespace
nmap <Leader>w :set list!<CR>
"Switch to last used buffer, map to CTRL-E
nmap <Leader>e :e#<CR> 
"Go to next/prev buffer
nmap <Leader>n :bnext<CR>
nmap <Leader>p :bprev<CR>

" Insert Mode Mappings
inoremap kj <Esc>
inoremap jj <Esc>

" Visual Mode Mappings
" }}}

" Autocommands {{{
augroup Vimrc
  autocmd! bufwritepost vimrc source %
augroup END
"}}}

" Snippets {{{
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" }}}

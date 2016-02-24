" __      ___
" \ \    / (_)
"  \ \  / / _ _ __ ___  _ __ ___
"   \ \/ / | | '_ ` _ \| '__/ __|
"    \  /  | | | | | | | | | (__
"     \/   |_|_| |_| |_|_|  \___|
	"

	" Vundle {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'vimoutliner/vimoutliner'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'rking/ag.vim' " Find code
Plugin 'scrooloose/nerdtree' " file browser
Plugin 'taglist.vim' " Browsing source code easier
Plugin 'majutsushi/tagbar' " Viewing source tree easier
Plugin 'bling/vim-airline' " Better status bar
Plugin 'kien/ctrlp.vim' " Search through files, buffers etc
Plugin 'tpope/vim-sensible' " Sensible defaults
Plugin 'tpope/vim-commentary' " Vim comments
Plugin 'tpope/vim-sleuth' " automatic spacing
Plugin 'tpope/vim-surround' " Adds support for modifying surrounds
Plugin 'tpope/vim-unimpaired' " Adds support for quick jumps in quickfix window
Plugin 'tpope/vim-fugitive' " Git support
Plugin 'mbbill/undotree' " Undo tree
Plugin 'Shougo/neocomplcache.vim' " Autocomplete
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'


" Colorschemes
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized' "Solarized colourscheme

" Language Support
Plugin 'vim-ruby/vim-ruby' " ruby lang support
Plugin 'klen/python-mode' " Python lang support

" Syntax Highlighters
Plugin 'mxw/vim-jsx'
Plugin 'potatoesmaster/i3-vim-syntax' " Provide syntax highlighting for i3 window manager

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" }}}

set mouse=a " Turn mouse support on
set nrformats= " Treat all numbers as decimal
set nocompatible " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set nu
set omnifunc=syntaxcomplete#Complete " Turn on autocomplete
set showcmd " display incomplete commands

" Solarized Colorscheme {{{
"set background=dark
"let g:solarized_termtrans=1
"let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"let g:solarized_visibility="high"
"let g:molokai_original = 1
"let g:rehash256 = 1
colorscheme molokai
set t_Co=256
set background=dark
"highlight Normal ctermbg=NONE
"highlight nonText ctermbg=NONE
" }}}

" PyMode {{{
" BUG: https://github.com/klen/python-mode/issues/525
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0
" }}}

" Map leader key
let mapleader = ","

set backspace=indent
set backspace+=eol
set backspace+=start

" Edit vimrc with <leader> v
nnoremap <leader>v :tabedit $MYVIMRC<CR>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

set directory=$HOME/.dotfiles/caches/ " Set the directory to store .swp files
set tags=./tags;/

" Store persistent undo
if has("persistent_undo")
 set undodir='$HOME/.dotfiles/caches/'
 set undofile
endif

" Remap ESC to be easier to type
:inoremap kj <Esc>

" Reselect block after indent
vnoremap < <gv
vnoremap > >gv

" Shortcut to rapidly toggle `set list`
:nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" switch to last used buffer, map to CTRL-E
:nmap <C-e> :e#<CR>

" next and previous buffers CTRL-P & CTRL-N
:nmap <C-n> :bnext<CR>
:nmap <C-p> :bprev<CR>


" Set up copy and paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" wrap lines
:nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>

" Don't warn when switching unsaved buffers
set hidden

" Split Settings
set splitbelow
set splitright

" Win Settings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Save as root
cmap w!! w !sudo tee % > /dev/null

" Exit Insert Mode with jj
inoremap jj <Esc>

" enforce purity
"noremap  <Up> <Nop>
"noremap  <Down> <Nop>
"noremap  <Left> <Nop>
"noremap  <Right> <Nop>


"""""""""""""""""
" PLUGIN SETTINGS
"""""""""""""""""

" vim-airline {{{
"
let g:airline#extensions#tabline#enabled = 1 " Show buffers at top
" Change Tab Style
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline_powerline_fonts = 1
" }}}

" Turn on neocomplcache
let g:neocomplcache_enable_at_startup = 1


" CTRL-P Settings {{{

" CTRL-P Settings
:let g:ctrlp_map = '<Leader>t'
:let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" :let g:ctrlp_match_window_bottom = 0
" :let g:ctrlp_match_window_reversed = 0
:let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend|jar|class)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'

" CTRL-P buffers mapping
":nmap ; :CtrlPBuffer<CR>
nnoremap <Leader>u :UndotreeToggle<cr>

" }}}

" NERDTree {{{

" Show NERDTree
:nmap <Leader>e :NERDTreeToggle<CR>

" Show Current NERDTree file
:nmap \n :NERDTreeFind<CR>

" Close NERDTree if only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" }}}

nnoremap <F5> <esc>:w<enter>:!%:p<enter>
inoremap <F5> <esc>:w<enter>:!%:p<enter>

autocmd filetype crontab setlocal nobackup nowritebackup

au BufRead,BufNewFile *.md setlocal textwidth=80

if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" For local replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>
" Open splits bottom right
set splitbelow
set splitright


" Ultisnips settings {{{
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:snips_author="Neil Grogan"
let g:snips_github="dueyfinster"
let g:snips_email="neil@ngrogan.com"
" }}}

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" " Jump to anywhere you want with minimal keystrokes, with just one key
" binding.
" " `s{char}{label}`
nmap s <Plug>(easymotion-s)
" " or
" " `s{char}{char}{label}`
" " Need one more keystroke, but on average, it may be more comfortable.
" nmap s <Plug>(easymotion-s2)
"
" " Turn on case insensitive feature
" let g:EasyMotion_smartcase = 1
"
" " JK motions: Line motions
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)

" EasyMotion Colours {{{
hi link EasyMotionTarget Search
hi link EasyMotionTarget2First Search
hi link EasyMotionTarget2Second Search
hi link EasyMotionShade Comment
" }}}
"
" vim:foldmethod=marker:foldlevel=0

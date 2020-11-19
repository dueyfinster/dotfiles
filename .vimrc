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
Plugin 'airblade/vim-rooter'
Plugin 'vimoutliner/vimoutliner' " For creating outlines
Plugin 'editorconfig/editorconfig-vim'
Plugin 'benmills/vimux' " Interact with tmux in vim

" Finding Files / Grep-like {{{
Plugin 'rking/ag.vim' " Find code
Plugin 'scrooloose/nerdtree' " file browser
Plugin 'ctrlpvim/ctrlp.vim' " Search through files, buffers etc
" }}}

" Source Code Browsing {{{
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar' " Viewing source tree easier
" }}}

"Plugin 'bling/vim-airline' " Better status bar
Plugin 'tpope/vim-sensible' " Sensible defaults
Plugin 'tpope/vim-commentary' " Vim comments
Plugin 'tpope/vim-sleuth' " automatic spacing
Plugin 'tpope/vim-surround' " Adds support for modifying surrounds
Plugin 'tpope/vim-unimpaired' " Adds support for quick jumps in quickfix window
Plugin 'tpope/vim-fugitive' " Git support
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'


" Colorschemes
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized' "Solarized colourscheme

" Language Support
Plugin 'vim-ruby/vim-ruby' " ruby lang support
Plugin 'klen/python-mode' " Python lang support
Plugin 'leafgarland/typescript-vim' " typescript support
Plugin 'kchmck/vim-coffee-script' " Coffeescript support
Plugin 'ledger/vim-ledger' " Ledger accounting support

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" }}}

" Map leader key
let mapleader = ","

set mouse=a " Turn mouse support on
set nrformats= " Treat all numbers as decimal
set nocompatible " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set nu
set omnifunc=syntaxcomplete#Complete " Turn on autocomplete
set showcmd " display incomplete commands
" Don't make backups at all
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" {{{ Spelling Settings
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell
set spelllang=en_gb
set complete+=kspell
" nmap <silent> <leader>s :set spell!<CR>
" }}}

" Solarized Colorscheme {{{
"set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"let g:solarized_visibility="high"
colorscheme solarized
set background=dark
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
set t_Co=256
"highlight Normal ctermbg=NONE
"highlight nonText ctermbg=NONE
" }}}

" PyMode {{{
" BUG: https://github.com/klen/python-mode/issues/525
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0
" }}}


set backspace=indent
set backspace+=eol
set backspace+=start

" vimrc editing shortcuts {{{
" Edit vimrc with <leader> vv
nnoremap <leader>vv :tabedit $MYVIMRC<CR>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif
" }}}

" Set Cache Settings {{{
set directory=$HOME/.dotfiles/caches/ " Set the directory to store .swp files
set tags=./tags;/

" Store persistent undo
if has("persistent_undo")
 set undofile
 set undodir=$HOME/.dotfiles/caches
 set undolevels=1000         " How many undos
 set undoreload=10000        " number of lines to save for undo
endif
" }}}

" Move to last edited line if buffer reopened
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif


" Remap ESC to be easier to type
inoremap kj <Esc>
inoremap jj <Esc>

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

" Copy and Paste / Clipboard {{{
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
" }}}

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


" enforce purity for arrow keys
noremap  <Up> <Nop>
noremap  <Down> <Nop>
noremap  <Left> <Nop>
noremap  <Right> <Nop>

" PLUGIN SETTINGS {{{
"""""""""""""""""
" NERDTREE Settings {{{
map <Leader>e :NERDTreeToggle<CR>
nmap <Leader>n :NERDTreeFind<CR>
" }}}

" CTRL-P Settings {{{

" CTRL-P Settings
:let g:ctrlp_map = '<Leader>t'
" :let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
:let g:ctrlp_user_command = 'rg %s --files --color=never ""'
" Search open buffers with ctrlp
nnoremap <Leader>r :CtrlPBuffer<cr>
nnoremap <Leader>. :CtrlPTag<cr>
" :let g:ctrlp_match_window_bottom = 0
" :let g:ctrlp_match_window_reversed = 0
:let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\v\~$|\.(o|swp|pyc|wav|mp3|ttf|ogg|blend|jar|class)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'

" CTRL-P buffers mapping
":nmap ; :CtrlPBuffer<CR>
nnoremap <Leader>u :UndotreeToggle<cr>

" }}}

" {{{ Tagbar Plugin Settings
nnoremap <silent> <Leader>b :TagbarToggle<CR>
" }}}

nnoremap <F5> <esc>:w<enter>:!%:p<enter>
inoremap <F5> <esc>:w<enter>:!%:p<enter>

autocmd filetype crontab setlocal nobackup nowritebackup

au BufRead,BufNewFile *.md setlocal textwidth=80
" Ledger files with .ldg extentions
au BufNewFile,BufRead *.ldg,*.ledger,*.journal setf ledger

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


let g:rooter_patterns = ['Rakefile', 'pom.xml', '.git/', 'Gemfile', 'package.json']

function! RunInProjectDir(cmd)
  let root_dir = FindRootDirectory()
  if !empty(root_dir)
    VimuxRunCommand("cd ".root_dir)
  endif
  VimuxRunCommand(a:cmd)
endfunction

function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction

" Vimux Settings {{{

" Run the current project build
map <Leader>rn :call RunInProjectDir("npm run")<CR>
map <Leader>rm :call RunInProjectDir("mvn clean install")<CR>
map <Leader>rd :call RunInProjectDir("./run-docker.sh")<CR>
:let maplocalleader = "\\"
" If text is selected, save it in the v buffer and send to tmux
vmap <LocalLeader>vs "vy :call VimuxSlime()<CR>
" Select Paragraph and send to Tmux pane
nmap <LocalLeader>vs vip<LocalLeader>vs<CR>

" Inspect runner pane map
map <Leader>vi :VimuxInspectRunner<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Zoom the tmux runner page
map <Leader>vz :VimuxZoomRunner<CR>
" Clear the tmux history of the runner pane
map <Leader>vc :VimuxClearRunnerHistory<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>
" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Prompt for a command to run
vmap <Leader>vp "vy :call VimuxPromptCommand(@v)<CR>

" }}}

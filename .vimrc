" Mostly stolen from Yan Pritzer's most excellent Yadr (github.com/skwp/dotfiles)

" Plugins will be downloaded under the specified directory.
"call plug#begin('~/.vim/plugged')
" Declare the list of plugins.
"Plug 'tpope/vim-sensible'
"Plug 'junegunn/seoul256.vim'
"   NERDTree :
"Plug 'scrooloose/nerdtree'
"   NERDTree : Git integration
"Plug 'Xuyuanp/nerdtree-git-plugin'
"   If you need Vim help for vim-plug itself (e.g. :help plug-options), register vim-plug as a plugin.
"Plug 'junegunn/vim-plug'
" List ends here. Plugins become visible to Vim after this call.
"call plug#end()


" NERDTree OPTIONS START HERE
"   Open NERDTree by default
"autocmd vimenter * NERDTree
"   NERDTree : Closing NERDTree automatically
"let NERDTreeQuitOnOpen = 1
"   NERDTree : automatically close a tab if the only remaining window is NerdTree
"autocmd bufenter * if (winnr(“$”) == 1 && exists(“b:NERDTreeType”) && b:NERDTreeType == “primary”) | q | endif
"   NERDTree : Deleting files
" Automatically delete the buffer of the file you just deleted with NerdTree:
" let NERDTreeAutoDeleteBuffer = 1
"   NERDTree : Making it prettier
"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1

"Run :PlugUpdate to update the plugins.
"After the update is finished, you can review the changes by running :PlugDiff
"Run :PlugClean. It will detect and remove undeclared plugins.

"source ~/.vim/scripts.vim

" CUSTOM USER OPTIONS
"   turn syntax highlighting on
:syntax on
"   set 'numberline' option
":set nu
"   set 'autoindent' option
:set ai     
"   set 'tab stop' & 'shift width' options to the same value
:set ts=2 sw=2

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif
" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default


" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Custom Settings ========================
"so ~/.yadr/vim/settings.vim

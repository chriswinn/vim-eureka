" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" Declare the list of plugins.
"Plug 'tpope/vim-sensible'
"Plug 'junegunn/seoul256.vim'
"   NERDTree :
Plug 'scrooloose/nerdtree'
"   NERDTree : Git integration
Plug 'Xuyuanp/nerdtree-git-plugin'
"   If you need Vim help for vim-plug itself (e.g. :help plug-options), register vim-plug as a plugin.
Plug 'junegunn/vim-plug'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()


" NERDTree OPTIONS START HERE
"   Open NERDTree by default
autocmd vimenter * NERDTree
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

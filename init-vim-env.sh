#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
yum -y install git
echo '''
set tabstop=8
set shiftwidth=4
set softtabstop=4
set autoindent
filetype plugin on
let g:pydiction_location="/root/.vim/bundle/complete-dict"
let g:pydiction_menu_height=20
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"
let g:neocomplcache_enable_at_startup = 1
map <F2> : NERDTreeMirror<CR>
map <F2> : NERDTreeToggle<CR>
let NERDTreeChDirMode=2
let NERDTreeQuitOnOpen=1
let NERDTreeShowBookmarks=1
let NERDTreeDirArrows=0
''' >/root/.vimrc
#-------------------I am boring line------------------------------------
rm /root/.vim/ -rf
mkdir /root/.vim/bundle/ -p
mkdir /root/.vim/after/ftplugin/ -p
cd /root/.vim/
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/Shougo/neocomplcache.vim.git
git clone https://github.com/vim-scripts/Pydiction.git
cp /root/.vim/Pydiction/after/ftplugin/python_pydiction.vim  /root/.vim/after/ftplugin/
cp /root/.vim/Pydiction/complete-dict  /root/.vim/bundle/
rm /root/.vim/Pydiction/ -rf
mv /root/.vim/neocomplcache.vim/*  /root/.vim/
rm /root/.vim/README.md -rf 
rm /root/.vim/neocomplcache.vim/ -rf
cp /root/.vim/nerdtree/autoload/*  /root/.vim/autoload/
cp /root/.vim/nerdtree/doc/*  /root/.vim/doc/
cp /root/.vim/nerdtree/plugin/*  /root/.vim/plugin/
cp /root/.vim/nerdtree/lib  /root/.vim/ -R 
cp /root/.vim/nerdtree/syntax  /root/.vim/ -R
cp /root/.vim/nerdtree/nerdtree_plugin  /root/.vim/ -R
rm /root/.vim/nerdtree -rf
#-------------------I am boring line------------------------------------
printf "\n\n\n++++++++++Vim Env Created,Enjoy it :)++++++++++\n\n\n"

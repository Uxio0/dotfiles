#!/bin/bash

folder=`pwd`
force="f"
ln -s$force $folder/conky.conf ~
ln -s$force $folder/.mpdconf ~
ln -s$force $folder/.tmux.conf ~
ln -s$force $folder/.vimrc ~
ln -s$force $folder/.vim ~
ln -s$force $folder/.xinitrc ~
ln -s$force $folder/.Xresources ~
ln -s$force $folder/.Xmodmap ~
ln -s$force $folder/.xprofile ~
ln -s$force $folder/.zshrc ~
mkdir -p ~/.config
ln -s$force $folder/termite ~/.config

#Vim bundle
mkdir -p ~/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

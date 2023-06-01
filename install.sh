#!/bin/bash

folder=`pwd`
force="f"

mkdir -p ~/.config
ln -s$force $folder/conky.conf ~
ln -s$force $folder/.mpdconf ~
ln -s$force $folder/.tmux.conf ~
ln -s$force $folder/.vim ~
ln -s$force $folder/.xinitrc ~
ln -s$force $folder/.Xresources ~
ln -s$force $folder/.xprofile ~
ln -s$force $folder/.zshrc ~
ln -s$force $folder/.ncmpcpp ~
ln -s$force $folder/alacritty ~/.config
ln -s$force $folder/termite ~/.config
ln -s$force $folder/bspwm ~/.config
ln -s$force $folder/dunst ~/.config
ln -s$force $folder/sxhkd ~/.config
ln -s$force $folder/fontconfig ~/.config
ln -s$force $folder/polybar ~/.config
ln -s$force $folder/nvim ~/.config

#Vim bundle
# mkdir -p ~/.vim/bundle
# mkdir -p ~/.vim/{swap,undo,backup}
# git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#Neovim vim-plug https://github.com/junegunn/vim-plug#unix-1
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

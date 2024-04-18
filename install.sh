#!/bin/bash


# Link dotfiles

folder=`pwd`
force="f"

mkdir -p ~/.config
ln -s$force $folder/.Xresources ~
ln -s$force $folder/.tigrc ~
ln -s$force $folder/.vim ~
ln -s$force $folder/.xinitrc ~
ln -s$force $folder/.zshrc ~

for d in config/*/ ; do
    ln -s$force $folder/$d ~/.config
done

#Vim bundle
# mkdir -p ~/.vim/bundle
# mkdir -p ~/.vim/{swap,undo,backup}
# git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#Neovim vim-plug https://github.com/junegunn/vim-plug#unix-1
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Oh my zsh
git clone https://github.com/ohmyzsh/ohmyzsh ~/.oh-my-zsh/

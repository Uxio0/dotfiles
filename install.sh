#!/bin/bash

# Link dotfiles

folder=$(pwd)

mkdir -p $HOME/.config
ln -sf "$folder/.Xresources" $HOME
ln -sf "$folder/.tigrc" $HOME
ln -sf "$folder/.vim" $HOME
ln -sf "$folder/.xinitrc" $HOME
ln -sf "$folder/.zshrc" $HOME

for d in config/*/; do
  [ -d "$d" ] || continue
  ln -sf "$folder/$d" $HOME/.config
done

#Neovim vim-plug https://github.com/junegunn/vim-plug#unix-1
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Oh my zsh
ZSH="${ZSH:-$HOME/.oh-my-zsh/}"
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"
git clone https://github.com/ohmyzsh/ohmyzsh "$ZSH"
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

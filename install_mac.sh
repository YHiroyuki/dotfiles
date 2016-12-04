#!/bin/sh

set -eu

red=31
green=32
yellow=33
blue=34

function cecho {
    color=$1
    shift
    echo "\033[${color}m$@\033[m"
}

CURRENT_DIR=`pwd`

# check brew and install

# check zsh and install

cecho $green "\n----> setup gitconfig"
[ -e ~/.gitconfig.local ] || cat template/gitconfig_local > ~/.gitconfig.local
[ -e ~/.gitconfig ] && rm ~/.gitconfig
ln -s ${CURRENT_DIR}/_gitconfig ~/.gitconfig
[ -e ~/.gitignore ] && rm ~/.gitignore
ln -s ${CURRENT_DIR}/_gitignore ~/.gitignore

cecho $green "\n----> setup zsh"
mkdir -p ~/.zsh
[ -d ~/.zsh/zsh-syntax-highlighting ] || git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
[ -e ~/.zshrc ] && rm ~/.zshrc
ln -s ${CURRENT_DIR}/_zshrc ~/.zshrc
[ -e ~/.local.zsh ] || cat template/zsh_local > ~/.local.zsh

cecho $green "\n----> setup tmux"
[ -e ~/.tmux.conf ] && rm ~/.tmux.conf
ln -s ${CURRENT_DIR}/_tmux.conf ~/.tmux.conf
[ -d ~/.tmux ] && rm ~/.tmux
ln -s ${CURRENT_DIR}/_tmux ~/.tmux

cecho $green "\n----> setup vim"
[ -e ~/.vimrc ] && rm ~/.vimrc
ln -s ${CURRENT_DIR}/_vimrc ~/.vimrc
[ -e ~/.vimrc.keymap ] && rm ~/.vimrc.keymap
ln -s ${CURRENT_DIR}/_vimrc.keymap ~/.vimrc.keymap
[ -e ~/.vimrc.local ] && rm ~/.vimrc.local
ln -s ${CURRENT_DIR}/_vimrc.local ~/.vimrc.local

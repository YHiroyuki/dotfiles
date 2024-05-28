#!/bin/bash
set -eu

red=31
green=32
yellow=33
blue=34
cyan=36
function cecho {
    color=$1
    shift
    echo -e "\033[${color}m$@\033[m"
}

mkdir -p $HOME/work/
mkdir -p $HOME/work/src
mkdir -p $HOME/work/bin
mkdir -p $HOME/work/pkg

cecho $blue "Setup zsh"
if [ -e $HOME/.zshrc ]; then
    cecho $yellow "zshrc already exists. Skip."
else
    cat $HOME/.config/template/zshrc.zsh > $HOME/.zshrc
fi
mkdir -p $HOME/.config/zsh/plugins
if [ -d $HOME/.config/zsh/plugins/zsh-syntax-highlighting ]; then
    cecho $yellow "zsh-syntax-highlighting already exists. Skip."
else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.config/zsh/plugins/zsh-syntax-highlighting
fi

cecho $blue "Setup git"
if [ -e $HOME/.gitconfig ]; then
    cecho $yellow "gitconfig already exists. Skip."
else
    cat $HOME/.config/template/gitconfig > $HOME/.gitconfig
fi
if [ -e $HOME/.config/git/local.gitconfig ]; then
    cecho $yellow "local.gitconfig already exists. Skip."
else
    cat $HOME/.config/template/local.gitconfig > $HOME/.config/git/local.gitconfig
fi

cecho $blue "Setup tmux"
if [ -d $HOME/.config/tmux/plugins/tpm ]; then
    cecho $yellow "tmux package manager already exists. Skip."
else
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
fi
./.config/tmux/plugins/tpm/scripts/install_plugins.sh

cecho $blue "Setup neovim"

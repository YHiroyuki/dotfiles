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
cat $HOME/.config/template/zshrc.zsh > $HOME/.zshrc

cecho $blue "Setup git"
cat $HOME/.config/template/gitconfig > $HOME/.gitconfig
cat $HOME/.config/template/local.gitconfig > $HOME/.config/git/local.gitconfig

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


cecho $green "\n Setup Zsh"

# TODO file check
ln -s ${CURRENT_DIR}/zsh ~/.config/zsh


# TODO file check
echo "source ~/.config/zsh/.zshrc" >> ~/.zshrc

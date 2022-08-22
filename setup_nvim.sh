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


cecho $green "\n Setup Neovim"

ln -s ${CURRENT_DIR}/nvim ~/.config/nvim

pip3 install --upgrade pip --user
pip3 install neovim

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.config/nvim/dein
rm -rf installer.sh

cecho $yellow "Run dein install"
cecho $yellow "> nvim -c 'call dein#install()'"

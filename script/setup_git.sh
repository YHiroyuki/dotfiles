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


cecho $green "\nSetup Git"

# TODO file check
ln -s ${CURRENT_DIR}/git ~/.config/git

echo "[include]" >> ~/.gitconfig
echo "    path = ~/.config/git/.gitconfig" >> ~/.gitconfig

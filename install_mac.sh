#!/bin/sh

set -eu

CURRENT_DIR=`pwd`

# check brew and install

# check zsh and install

[ -e ~/.tmux.conf ] || ln -s ${CURRENT_DIR}/_tmux.conf ~/.tmux.conf

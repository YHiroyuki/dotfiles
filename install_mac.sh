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

if ! which brew > /dev/null; then
    cecho $red "Please install brew\n"
    exit 1
fi

# check brew and install
cecho $green "\n----> brew update and install commands"
brew update

brew bundle

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
[ -d ~/.vim/dein/repos/github.com/Shougo/dein.vim ] || (
    mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
    git clone https://github.com/Shougo/dein.vim.git ~/.vim/dein/repos/github.com/Shougo/dein.vim
)
[ -e ~/.vimrc ] && rm ~/.vimrc
ln -s ${CURRENT_DIR}/_vimrc ~/.vimrc
[ -e ~/.vimrc.keymap ] && rm ~/.vimrc.keymap
ln -s ${CURRENT_DIR}/_vimrc.keymap ~/.vimrc.keymap
[ -e ~/.vimrc.local ] && rm ~/.vimrc.local
ln -s ${CURRENT_DIR}/_vimrc.local ~/.vimrc.local

mkdir -p ~/.config/nvim

ln -s ${CURRENT_DIR}/nvim/dein.toml ~/.config/nvim/dein.toml
ln -s ${CURRENT_DIR}/nvim/dein_lazy.toml ~/.config/nvim/dein_lazy.toml
ln -s ${CURRENT_DIR}/nvim/colors.toml ~/.config/nvim/colors.toml
ln -s ${CURRENT_DIR}/nvim/ddu.toml ~/.config/nvim/ddu.toml
ln -s ${CURRENT_DIR}/nvim/init.vim ~/.config/nvim/init.vim

pip3 install --upgrade pip --user
pip3 install neovim

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.config/nvim/dein
rm -rf installer.sh

# powerlineのインストール
# [参考]
# https://qiita.com/park-jh/items/557a9d5b470947aef2f5
# https://qiita.com/mktktmr/items/5481eac60b96c80cc262

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -vf


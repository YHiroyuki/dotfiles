export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/work
export MANPATH=/opt/local/man:$MANPATH
export PHPBREW_SET_PROMPT=1
export GO15VENDOREXPERIMENT=1
export HOMEBREW_NO_AUTO_UPDATE=1
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
autoload -U compinit
compinit -u
bindkey -v

# # vi modeのyankをclipboardにコピー
# function vi-yank-xclip {
#     zle vi-yank
#    echo "$CUTBUFFER" | pbcopy -i
# }
# 
# zle -N vi-yank-xclip
# bindkey -M vicmd 'y' vi-yank-xclip

branch_flag=true

[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

export PYENV_ROOT="${HOME}/.pyenv"
if which pyenv > /dev/null; then
    eval "$(pyenv init -)"
    eval "$(pyenv init --path)"
fi
if which rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi
if [ "$(uname)" = "Darwin" ]; then
    # Mac
    alias tac="tail -r"

fi

export PATH=$HOME/.nodebrew/current/bin:$HOME/.rbenv/bin:/usr/local/bin:$HOME/.phpenv/bin:/usr/local/texlive/2014/bin:/opt/local/bin:/usr/local/mysql/bin:/opt/local/sbin:$PATH:$GOPATH/bin

GHQ_ROOT=`ghq root | sed -e "s:^$HOME:~:"`
zstyle ':completion:*:default' menu select=1
# ------- PROMPT SETTING ----------------------
RPROMPT=$'`branch-status-check`' # %~はpwd
function custom-pwd {
    pwd | perl -pe "s:^`ghq root`\/.+?\/:ghq\::" | sed -e "s:^$HOME:~:"
}
function my-pwd {
    local current=`pwd | sed -e "s:^$HOME:~:"`
    if [[ "$current" =~ ^$GHQ_ROOT ]]; then
        echo $current | perl -pe "s:^$GHQ_ROOT\/.+?\/:[ghq]\::"
        return
    fi
    if [ "$current" = "~" ]; then
        echo $current
        return
    fi

    local dirname=`dirname $current | sed -e "s:\(\/.\)[^\/]*:\1:g"`
    local basename=`basename $current`
    echo "$dirname/$basename"
}

PROMPT_NOR=$'%{$fg[white]%}`my-pwd`%{$reset_color%} %{$fg[cyan]%}❰%{$fg[blue]%}❰%{$fg[red]%}❰%{$reset_color%}'
PROMPT_INS=$'%{$fg[blue]%}`my-pwd`%{$reset_color%} %{$fg[red]%}❱%{$fg[blue]%}❱%{$fg[cyan]%}❱%{$reset_color%}'
PROMPT_VIS=$'%{$fg[yellow]%}`my-pwd`%{$reset_color%} %{$fg[red]%}❰%{$fg[blue]%}❰%{$fg[cyan]%}❰%{$reset_color%}'
PROMPT=$PROMPT_INS
function zle-line-pre-redraw {
  if [[ $REGION_ACTIVE -ne 0 ]]; then
    NEW_PROMPT=$PROMPT_VIS
  elif [[ $KEYMAP = vicmd ]]; then
    NEW_PROMPT=$PROMPT_NOR
  elif [[ $KEYMAP = main ]]; then
    NEW_PROMPT=$PROMPT_INS
  fi

  if [[ $PROMPT = $NEW_PROMPT ]]; then
    return
  fi

  PROMPT=$NEW_PROMPT

  zle reset-prompt
}
function zle-line-init zle-keymap-select {
    case $KEYMAP in
        vicmd)
        PROMPT=$PROMPT_NOR
        ;;
        main|viins)
        PROMPT=$PROMPT_INS
        ;;
    esac
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-pre-redraw
setopt prompt_subst #表示毎にPROMPTで設定されている文字列を評価する
# ---------------------------------------------

HISTFILE=${HOME}/.config/zsh/.zsh_history
HISTSIZE=100000
SAVEHIST=1000000
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt inc_append_history
setopt share_history
setopt EXTENDED_HISTORY
setopt hist_ignore_space

#cd ../のときに今いるディレクトリを表示しない
zstyle ':completion:*' ignore-parents parent pwd ..

#if [[ ! -n $TMUX && $- == *l* ]]; then
#  # get the IDs
#  ID="`tmux list-sessions`"
#  if [[ -z "$ID" ]]; then
#    tmux new-session
#  fi
#  create_new_session="Create New Session"
#  ID="$ID\n${create_new_session}:"
#  ID="`echo $ID | fzf | cut -d: -f1`"
#  if [[ "$ID" = "${create_new_session}" ]]; then
#    tmux new-session
#  elif [[ -n "$ID" ]]; then
#    tmux attach-session -t "$ID"
#  else
#    :  # Start terminal normally
#  fi
#fi

zle -N change-flag
zle -N git-branch-src
zle -N peco-src
zle -N peco-history-selection

bindkey '^\' change-flag
bindkey '^r' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
# peco+ghq Gitのリポジトリを一覧表示
# ghq get (Git repos PATH)
bindkey '^]' peco-src
# Ctrl+g gitのブランチをぺこ
bindkey '^g' git-branch-src
bindkey '^R' peco-history-selection

function peco-history-selection() {
    BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | fzf --no-sort`
    CURSOR=$#BUFFER
    zle reset-prompt
}


function git-branch-src(){
    local selected_branch=$(git branch | fzf | cut -c3-)
    if [ -n "$selected_branch" ]; then
        BUFFER="git checkout ${selected_branch}"
        zle accept-line
    fi
    zle clear-screen
}

function php-switch() {
    local selected_php=$(phpbrew list | fzf | cut -c3-)
    if [ -n "$selected_php" ]; then
        phpbrew switch ${selected_php}
    fi
    clear
}

function change-flag(){
    if $branch_flag ; then
        branch_flag=false
    else
        branch_flag=true
    fi
    zle accept-line
}

# --------------- alias ---------------------
alias tmux="tmux"
alias ll="ls -al"
alias vi="vim -u NONE -N"

# ------------------ functions --------------------
# {{{ methods for RPROMPT
# fg[color]表記と$reset_colorを使いたい
# @see https://wiki.archlinux.org/index.php/zsh
autoload -U colors; colors
function branch-status-check {
    local prefix branchname suffix
        # .gitの中だから除外
        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
            return
        fi
        branchname=`get-branch-name`
        # ブランチ名が無いので除外
        if [[ -z $branchname ]]; then
            return
        fi
        # if $branch_flag; then
        #     branchname='♨ '
        #     # branchname=':('
        # fi
        prefix=`get-branch-status` #色だけ返ってくる
        suffix='%{'${reset_color}'%}'
        # echo ${prefix}${branchname}${suffix}
        green='%{'${fg[green]}'%}'
        echo ${prefix} ${branchname}${suffix}
}
function get-branch-name {
    # gitディレクトリじゃない場合のエラーは捨てます
    echo `git rev-parse --abbrev-ref HEAD 2> /dev/null`
}
function get-branch-status {
    local res color
        output=`git status --short 2> /dev/null`
        if [ -z "$output" ]; then
            res=':' # status Clean
            color='%{'${fg[green]}'%}'
        elif [[ $output =~ "[\n]?\?\? " ]]; then
            res='?:' # Untracked
            color='%{'${fg[yellow]}'%}'
        elif [[ $output =~ "[\n]? M " ]]; then
            res='M:' # Modified
            color='%{'${fg[red]}'%}'
        else
            res='A:' # Added to commit
            color='%{'${fg[cyan]}'%}'
        fi
        # echo ${color}${res}'%{'${reset_color}'%}'
        echo ${color} # 色だけ返す
}

#left prompt setting
function battery-status
{
    name='%n'
    arrow='->'
    suffix='%{'${reset_color}'%}'
    local color
    battery=`ioreg -n AppleSmartBattery | awk '/MaxCapacity/{ MAX=$5 }
        /CurrentCapacity/{ CURRENT=$5 }
        END { printf("%.0f\n",CURRENT/MAX*100)}'`
    if [[ ${battery} < 30 ]] then color='%{'${fg[red]}'%}'
    elif [[ ${battery} < 50 ]] then color='%{'${fg[magenta]}'%}'
    elif [[ ${battery} < 70 ]] then color='%{'${fg[yellow]}'%}'
    elif [[ ${battery} < 90 ]] then color='%{'${fg[green]}'%}'
    else color='%{'${fg[cyan]}'%}'
    fi
    color='%{'${fg[cyan]}'%}'
    echo ${color}${name}${suffix}${arrow}
}

function pyenv-status
{
    pyenv=`pyenv version|cut -d" " -f1`
    if [ "${pyenv}" = "system" ]; then
        pyversion=""
    else
        pyversion="${pyenv}"
    fi
    echo "%{"${fg[yellow]}"%}"${pyversion}"%{"${reset_color}"%}"
}


############################################################
# Manegiment Git Repository
# Use:
#   ghq
#   peco
# Memo:
#   ghq get (Git Repository PATH)
############################################################
function peco-src () {
    local selected_dir=$(ghq list -p | fzf)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}

#---------------------------------------------------------------
# pyenv
#export PYENV_ROOT="${HOME}/.pyenv"
#if [ -d "${PYENV_ROOT}" ]; then
#    export PATH=${PYENV_ROOT}/bin:$PATH
#    eval "$(pyenv init -)"
# if which tmux 2>&1 >/dev/null; then
#     test -z "$TMUX" && (tmux attach || tmux new-session)
# fi

function notify () {
    case $? in
        0 ) echo "display notification \"SUCCESS\" with title \"$1\"" | osascript - ;;
        * )echo "display notification \"!!!!!!FAILD!!!!!\" with title \"$1\"" | osascript - ;;
    esac
 }

if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/Users/yamawaki/sdk/cocos2d-x-3.15.1/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_X_ROOT for cocos2d-x
export COCOS_X_ROOT=/Users/yamawaki/sdk
export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
export COCOS_TEMPLATES_ROOT=/Users/yamawaki/sdk/cocos2d-x-3.15.1/templates
export PATH=$COCOS_TEMPLATES_ROOT:$PATH

# Add environment variable ANDROID_SDK_ROOT for cocos2d-x
export ANDROID_SDK_ROOT=/Users/yamawaki/Library/Android/sdk
export PATH=$ANDROID_SDK_ROOT:$PATH
export PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH
# export PATH="/usr/local/opt/bzip2/bin:$PATH"
if which phpenv > /dev/null; then
    eval "$(phpenv init -)"
fi


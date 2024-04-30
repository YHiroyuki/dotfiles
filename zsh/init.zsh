export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/work
export MANPATH=/opt/local/man:$MANPATH
export PHPBREW_SET_PROMPT=1
export GO15VENDOREXPERIMENT=1
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
autoload -U compinit
compinit -u
bindkey -v


if [ -f ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

export PYENV_ROOT="${HOME}/.pyenv"
if which pyenv > /dev/null; then
    eval "$(pyenv init -)"
    eval "$(pyenv init --path)"
fi
if which rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi

# Mac固有の設定
if [ "$(uname)" = "Darwin" ]; then
    # tacコマンドをalias
    alias tac="tail -r"
    # homebrewの自動アップデートを無効
    export HOMEBREW_NO_AUTO_UPDATE=1
fi

# --------------- alias ---------------------
alias tmux="tmux"
alias ll="ls -al"
alias vi="vim -u NONE -N"


export PATH=$HOME/.nodebrew/current/bin:$HOME/.rbenv/bin:/usr/local/bin:$HOME/.phpenv/bin:/usr/local/texlive/2014/bin:/opt/local/bin:/usr/local/mysql/bin:/opt/local/sbin:$PATH:$GOPATH/bin

GHQ_ROOT=`ghq root | sed -e "s:^$HOME:~:"`
zstyle ':completion:*:default' menu select=1
#cd ../のときに今いるディレクトリを表示しない
zstyle ':completion:*' ignore-parents parent pwd ..

# ローカル、サーバの切り替え
if [ "${WHEN_LOCAL}" -eq "1" ]; then
    PROMPT_NOR=$'%{$fg[white]%}`my-pwd`%{$reset_color%} %{$fg[cyan]%}❰%{$fg[blue]%}❰%{$fg[red]%}❰%{$reset_color%}'
    PROMPT_INS=$'%{$fg[blue]%}`my-pwd`%{$reset_color%} %{$fg[red]%}❱%{$fg[blue]%}❱%{$fg[cyan]%}❱%{$reset_color%}'
    PROMPT_VIS=$'%{$fg[yellow]%}`my-pwd`%{$reset_color%} %{$fg[red]%}❰%{$fg[blue]%}❰%{$fg[cyan]%}❰%{$reset_color%}'
else

    PROMPT_NOR=$'%{$fg[white]%}%n%{$reset_color%} ❰'
    PROMPT_INS=$'%{$fg[blue]%}%n%{$reset_color%} ❱'
    PROMPT_VIS=$'%{$fg[yellow]%}%n%{$reset_color%} ❰'
fi
PROMPT=$PROMPT_INS
RPROMPT=$'`branch-status-check`'

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


zle -N my-source-file-selection
zle -N my-history-selection

bindkey '^r' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
# peco+ghq Gitのリポジトリを一覧表示
# ghq get (Git repos PATH)
bindkey '^]' my-source-file-selection
# Ctrl+g gitのブランチをぺこ
bindkey '^R' my-history-selection

function my-history-selection() {
    BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | fzf --no-sort --color 'border:#A3BE8C'`
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
        # 色だけ返す
        echo ${color}
}

function my-source-file-selection () {
    local selected_dir=$(ghq list -p | fzf --color 'border:#D08770')
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
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

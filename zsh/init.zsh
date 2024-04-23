# 環境変数
export GOPATH=$HOME/work
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

autoload -U compinit
compinit -u
# 色の設定
# @see https://wiki.archlinux.org/index.php/zsh
autoload -U colors; colors
zstyle ':completion:*' ignore-parents parent pwd ..

# vi mode
bindkey -v

# Mac固有の設定
if [ "$(uname)" = "Darwin" ]; then
    alias tac="tail -r"
    export HOMEBREW_NO_AUTO_UPDATE=1
fi

# 履歴
HISTFILE=${HOME}/.config/zsh/.zsh_history
HISTSIZE=100000
SAVEHIST=1000000
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt inc_append_history
setopt share_history
setopt EXTENDED_HISTORY
setopt hist_ignore_space
zle -N my-history-selection
bindkey '^r' my-history-selection
function my-history-selection() {
    BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | fzf --no-sort`
    CURSOR=$#BUFFER
    zle reset-prompt
}

# Git関連
zle -N my-ghq-source-selection
bindkey '^]' my-ghq-source-selection
function my-ghq-source-selection () {
    local selected_dir=$(ghq list -p | fzf)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}


# ローカル、サーバの切り替え
if [ "${WHEN_LOCAL}" -eq "1" ]; then
    PROMPT='hoge $'
else
    PROMPT="${fg[blue]}%n${reset_color} $"
fi

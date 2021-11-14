######################################
# 環境変数
# 全般
export LANG=ja_JP.UTF-8
export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
export LESS='-R'
export PAGER=less
export EDITOR=nvim
export VISUAL=nvim
export MAIL=~/Maildir
export BROWSER=w3m

# bemenuの設定
export BEMENU_BACKEND=curses
export BEMENU_OPTS='--scrollbar=autohide'

# sshの設定
eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# pyenvの設定
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
fi

# poetryの設定
export PATH="$HOME/.poetry/bin:$PATH"

# rbenvの設定
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# nodenvの設定
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# goenvの設定
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"

# rustupの設定
source "$HOME/.cargo/env"

# dotnetの設定
export PATH="$HOME/.dotnet/tools:$PATH"

# PATHの重複を除去
typeset -U PATH

#!/usr/bin/zsh

#######################################
# プラグイン
# プラグイン管理はzinitを使用
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# プラグイン読込
zinit light zdharma-continuum/zinit-annex-as-monitor
zinit light zdharma-continuum/zinit-annex-bin-gem-node
zinit light zdharma-continuum/zinit-annex-patch-dl
zinit light zdharma-continuum/zinit-annex-rust
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light zdharma/history-search-multi-word
zinit light romkatv/powerlevel10k
zinit light asdf-vm/asdf

# powerlevel10k読込
[[ ! -f $HOME/.p10k.zsh ]] || source ~/.p10k.zsh

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
[[ -z "$BROWSER" ]] && export BROWSER=w3m

# bemenuの設定
export BEMENU_BACKEND=curses
export BEMENU_OPTS='--scrollbar=autohide'

# sshの設定
eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh 2>/dev/null)
export SSH_AUTH_SOCK

# asdfの設定
if [[ ! -d $HOME/.asdf ]]; then
    print -P "%F{33} %F{220}Installing %F{33}asdf%F{220} tool version manager…%f"
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Instllation failed.%f%b"
fi

# pyenvの設定
if [[ ! -d $HOME/.pyenv ]]; then
    print -P "%F{33} %F{220}Installing %F{33}pyenv%F{220} python version manager…%f"
    curl https://pyenv.run | bash && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Instllation failed.%f%b"
fi
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# poetryの設定
if [[ ! -d $HOME/.poetry ]]; then
    print -P "%F{33} %F{220}Installing %F{33}poetry%F{220} python environment manager…%f"
    curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Instllation failed.%f%b"
fi
export PATH="$HOME/.poetry/bin:$PATH"

# rustupの設定
if [[ ! -d $HOME/.cargo ]]; then
    print -P "%F{33} %F{220}Installing %F{33}rustup%F{220} rust tool manager…%f"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Instllation failed.%f%b"
fi
[[ -f $HOME/.cargo/env ]] && source "$HOME/.cargo/env"

# dotnetの設定
[[ -f $HOME/.asdf/plugins/dotnet-core/set-dotnet-home.zsh ]] && \
    source "$HOME/.asdf/plugins/dotnet-core/set-dotnet-home.zsh"
export PATH="$HOME/.dotnet/tools:$PATH"

# ghcupの設定
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# userの設定
export PATH="$HOME/bin:$PATH"

# PATHの重複を除去
typeset -U PATH

#######################################
# 全般
# 色を使用出来るようにする
autoload -Uz colors
colors

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# asdfの設定
fpath=(${ASDF_DIR}/completions $fpath)

# zfuncの設定
[[ ! -d $HOME/.zfunc ]] && mkdir ~/.zfunc
if [[ ! -f $HOME/.zfunc/_poetry ]]; then
    print -P "%F{33} %F{220}Installing %F{33}poetry%F{220} completions…%f"
    poetry completions zsh > ~/.zfunc/_poetry && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Instllation failed.%f%b"
fi
if [[ ! -f $HOME/.zfunc/_rustup ]]; then
    print -P "%F{33} %F{220}Installing %F{33}rustup%F{220} completions…%f"
    rustup completions zsh > ~/.zfunc/_rustup && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Instllation failed.%f%b"
fi
if [[ ! -f $HOME/.zfunc/_cargo ]]; then
    print -P "%F{33} %F{220}Installing %F{33}cargo%F{220} completions…%f"
    ln -sf ~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/share/zsh/site-functions/_cargo ~/.zfunc/_cargo && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Instllation failed.%f%b"
fi
fpath+=~/.zfunc

# dotnetの設定
_dotnet_zsh_complete()
{
    local completions=("$(dotnet complete "$words")")
    reply=( "${(ps:\n:)completions}" )
}
if command -v dotnet 1>/dev/null 2>&1; then
    compctl -K _dotnet_zsh_complete dotnet
fi

# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# エイリアス
alias la='ls -a'
alias ll='ls -l'
alias ls='ls -F --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias diff='colordiff -u'
alias grep='grep --color=auto'
alias vi='nvim'
alias vim='nvim'

########################################
# tmux自動起動
# VSCodeのときは起動しない
# fzf使用
if [[ -z "$TMUX" && ! -z "$PS1" && $TERM_PROGRAM != "vscode" ]]; then
    PERCOL="fzf"
    ID="$(tmux list-sessions 2>/dev/null)"
    if [[ -z "$ID" ]]; then
        tmux new-session
    else
        CREATE_NEW_SESSION="Create New Session"
        ID="$ID\n${CREATE_NEW_SESSION}:"
        ID="`echo $ID | $PERCOL | cut -d: -f1`"
        if [[ "$ID" = "${CREATE_NEW_SESSION}" ]]; then
            tmux new-session
        elif [[ -n "$ID" ]]; then
            tmux attach-session -t "$ID"
        fi
    fi
fi

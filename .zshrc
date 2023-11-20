#!/usr/bin/zsh

#######################################
# Plugins
# zinit
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

# load plugins
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

# load powerlevel10k
[[ ! -f $HOME/.p10k.zsh ]] || source ~/.p10k.zsh

######################################
# Environment variables
# basic
export LANG=ja_JP.UTF-8
export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
export LESS='-R'
export PAGER=less
export EDITOR=nvim
export VISUAL=nvim
export MAIL=~/Maildir
[[ ! -z "$BROWSER" ]] || export BROWSER=w3m

# bemenu
export BEMENU_BACKEND=curses
export BEMENU_OPTS='--scrollbar=autohide'

# ssh
eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh 2>/dev/null)
export SSH_AUTH_SOCK

# pyenv
if [[ ! -d $HOME/.pyenv ]]; then
    print -P "%F{33} %F{220}Installing %F{33}pyenv%F{220} python version manager…%f"
    curl https://pyenv.run | bash && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Installation failed.%f%b"
fi
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# poetry
if [[ ! -d $HOME/.local/share/pypoetry ]]; then
    print -P "%F{33} %F{220}Installing %F{33}poetry%F{220} python environment manager…%f"
    curl -sSL https://install.python-poetry.org | python3 - && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Installation failed.%f%b"
fi

# rustup
if [[ ! -d $HOME/.cargo ]]; then
    print -P "%F{33} %F{220}Installing %F{33}rustup%F{220} rust tool manager…%f"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Installation failed.%f%b"
fi
[[ ! -f $HOME/.cargo/env ]] || source "$HOME/.cargo/env"

# go
if command -v go 1>/dev/null 2>&1; then
    export PATH="$(go env GOPATH)/bin:$PATH"
fi

# ghcup
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# asdf dotnet
[[ ! -f $HOME/.asdf/plugins/dotnet/set-dotnet-home.zsh ]] || \
    source "$HOME/.asdf/plugins/dotnet/set-dotnet-home.zsh"
export PATH="$HOME/.dotnet/tools:$PATH"

# etc
export PATH="$HOME/bin:$PATH"
export JAVA_WORKSPACE="$HOME/.workspace"

typeset -U PATH

#######################################
# Generics
# colors
autoload -Uz colors
colors

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# word delimiter
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# Completions
# asdf
fpath=(${ASDF_DIR}/completions $fpath)

# zfunc
[[ -d $HOME/.zfunc ]] || mkdir ~/.zfunc
if [[ ! -f $HOME/.zfunc/_poetry ]]; then
    print -P "%F{33} %F{220}Installing %F{33}poetry%F{220} completions…%f"
    poetry completions zsh > ~/.zfunc/_poetry && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Installation failed.%f%b"
fi
if [[ ! -f $HOME/.zfunc/_rustup ]]; then
    print -P "%F{33} %F{220}Installing %F{33}rustup%F{220} completions…%f"
    rustup completions zsh > ~/.zfunc/_rustup && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Installation failed.%f%b"
fi
if [[ ! -f $HOME/.zfunc/_cargo ]]; then
    print -P "%F{33} %F{220}Installing %F{33}cargo%F{220} completions…%f"
    ln -sf ~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/share/zsh/site-functions/_cargo ~/.zfunc/_cargo && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Installation failed.%f%b"
fi
if command -v minikube 1>/dev/null 2>&1; then
    if [[ ! -f $HOME/.zfunc/_minikube ]]; then
        print -P "%F{33} %F{220}Installing %F{33}minikube%F{220} completions…%f"
        minikube completion zsh > ~/.zfunc/_minikube && \
            print -P "%F{33} %F{34}Installation successful.%f%b" || \
            print -P "%F{160} Installation failed.%f%b"
    fi
fi
if command -v kind 1>/dev/null 2>&1; then
    if [[ ! -f $HOME/.zfunc/_kind ]]; then
        print -P "%F{33} %F{220}Installing %F{33}kind%F{220} completions…%f"
        kind completion zsh > ~/.zfunc/_kind && \
            print -P "%F{33} %F{34}Installation successful.%f%b" || \
            print -P "%F{160} Installation failed.%f%b"
    fi
fi
fpath+=~/.zfunc

# load completion
autoload -Uz compinit
compinit
autoload -U +X bashcompinit
bashcompinit

# dotnet
_dotnet_zsh_complete() {
    local completions=("$(dotnet complete "$words")")
    if [ -z "$completions" ]; then
        _arguments '*::arguments: _normal'
        return
    fi
    _values = "${(ps:\n:)completions}"
}
if command -v dotnet 1>/dev/null 2>&1; then
    compdef _dotnet_zsh_complete dotnet
fi

# terraform
if command -v terraform 1>/dev/null 2>&1; then
    complete -o nospace -C terraform terraform
fi

# azure-cli
[[ -d $HOME/.azure-cli ]] || mkdir ~/.azure-cli
if [[ ! -f $HOME/.azure-cli/az.completion ]]; then
    print -P "%F{33} %F{220}Installing %F{33}azure-cli%F{220} completions…%f"
    curl -o $HOME/.azure-cli/az.completion https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Installation failed.%f%b"
fi
source $HOME/.azure-cli/az.completion

# ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ignore parents (../)
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# ps
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

########################################
# Options
setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt extended_glob

########################################
# Alias
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
# tmux
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

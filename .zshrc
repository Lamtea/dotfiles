#!/usr/bin/zsh

#######################################
# Plugins
# zinit
ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$(dirname $ZINIT_HOME)" && command git clone https://github.com/zdharma-continuum/zinit "${ZINIT_HOME}" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# load plugins
zinit light zdharma-continuum/zinit-annex-as-monitor
zinit light zdharma-continuum/zinit-annex-bin-gem-node
zinit light zdharma-continuum/zinit-annex-patch-dl
zinit light zdharma-continuum/zinit-annex-rust
zinit light zdharma/history-search-multi-word
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light romkatv/powerlevel10k

# load powerlevel10k
[[ ! -f "${HOME}/.p10k.zsh" ]] || source "${HOME}/.p10k.zsh"

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
[[ ! -z "${BROWSER}" ]] || export BROWSER=w3m

# for rootless docker
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

# bemenu
export BEMENU_BACKEND=curses
export BEMENU_OPTS='--scrollbar=autohide'

# ssh
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gcr/ssh"

# python-build
export PYTHON_CONFIGURE_OPTS="--enable-optimizations --with-lto"
export PYTHON_CFLAGS="-march=native -mtune=native"
export PROFILE_TASK="-m test.regrtest --pgo -j0"

# rustup
if [[ ! -d "${HOME}/.cargo" ]]; then
    print -P "%F{33} %F{220}Installing %F{33}rustup%F{220} rust tool manager… %f"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Installation failed.%f%b"
fi
[[ ! -f "${HOME}/.cargo/env" ]] || source "${HOME}/.cargo/env"

# ghcup
if [[ ! -d "${HOME}/.ghcup/bin" ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ghcup%F{220} haskell environment manager… %f"
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Installation failed.%f%b"
fi
export PATH="${HOME}/.ghcup/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"

# mise
if [[ ! -f "${HOME}/.local/bin/mise" ]]; then
    print -P "%F{33} %F{220}Installing %F{33}mise%F{220} tool manager… %f"
        curl https://mise.run | sh && \
            print -P "%F{33} %F{34}Installation successful.%f%b" || \
            print -P "%F{160} Installation failed.%f%b"
fi
eval "$("${HOME}/.local/bin/mise" activate zsh)"
export MISE_CACHE_PRUNE_AGE=0

# go
if command -v go 1>/dev/null 2>&1; then
    export PATH="$(go env GOPATH)/bin:${PATH}"
fi

# php composer
export PATH="${HOME}/vendor/bin:${PATH}"

# java
export JAVA_WORKSPACE="${HOME}/.workspace"

# android sdk
export ANDROID_HOME=/opt/android-sdk

# local bin
export PATH="${HOME}/bin:${PATH}"

typeset -U PATH

#######################################
# Generics
# colors
autoload -Uz colors
colors

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# word delimiter
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# Completions
# zfunc
[[ -d "${HOME}/.zfunc" ]] || mkdir "${HOME}/.zfunc"
if command -v rustup 1>/dev/null 2>&1; then
    rustup completions zsh > "${HOME}/.zfunc/_rustup"
fi
if command -v cargo 1>/dev/null 2>&1; then
    ln -sf "${HOME}/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/share/zsh/site-functions/_cargo" "${HOME}/.zfunc/_cargo"
fi
if [[ ! -f "${HOME}/.zfunc/_ghcup" ]]; then
    curl -o "${HOME}/.zfunc/_ghcup" https://raw.githubusercontent.com/haskell/ghcup-hs/master/scripts/shell-completions/zsh
fi
if command -v mise 1>/dev/null 2>&1; then
    mise completion --usage zsh > "${HOME}/.zfunc/_mise"
fi
if command -v uv 1>/dev/null 2>&1; then
    uv generate-shell-completion zsh > "${HOME}/.zfunc/_uv"
fi
if command -v ruff 1>/dev/null 2>&1; then
    ruff generate-shell-completion zsh > "${HOME}/.zfunc/_ruff"
fi
if command -v pnpm 1>/dev/null 2>&1; then
    pnpm completion zsh > "${HOME}/.zfunc/_pnpm"
fi
if command -v bun 1>/dev/null 2>&1; then
    bun completions zsh > "${HOME}/.zfunc/_bun"
fi
if command -v deno 1>/dev/null 2>&1; then
    deno completions zsh > "${HOME}/.zfunc/_deno"
fi
if command -v golangci-lint 1>/dev/null 2>&1; then
    golangci-lint completion zsh > "${HOME}/.zfunc/_golangci-lint"
fi
if command -v gh 1>/dev/null 2>&1; then
    gh completion -s zsh > "${HOME}/.zfunc/_gh"
fi
if command -v buf 1>/dev/null 2>&1; then
    buf completion zsh > "${HOME}/.zfunc/_buf"
fi
if command -v tree-sitter 1>/dev/null 2>&1; then
    tree-sitter complete -s zsh > "${HOME}/.zfunc/_tree-sitter"
fi
if command -v jwt 1>/dev/null 2>&1; then
    jwt completion zsh > "${HOME}/.zfunc/_jwt"
fi
if command -v yq 1>/dev/null 2>&1; then
    yq completion zsh > "${HOME}/.zfunc/_yq"
fi
if command -v minikube 1>/dev/null 2>&1; then
    minikube completion zsh > "${HOME}/.zfunc/_minikube"
fi
if command -v kind 1>/dev/null 2>&1; then
    kind completion zsh > "${HOME}/.zfunc/_kind"
fi
if command -v argocd 1>/dev/null 2>&1; then
    argocd completion zsh > "${HOME}/.zfunc/_argocd"
fi
if command -v helmfile 1>/dev/null 2>&1; then
    helmfile completion zsh > "${HOME}/.zfunc/_helmfile"
fi
if command -v azcopy 1>/dev/null 2>&1; then
    azcopy completion zsh > "${HOME}/.zfunc/_azcopy"
fi
fpath=("${HOME}/.zfunc" $fpath)

# load zsh completion
autoload -Uz compinit
compinit

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

# kubeadm
if command -v kubeadm 1>/dev/null 2>&1; then
    source <(kubeadm completion zsh)
fi

# valkey
if command -v valkey-cli 1>/dev/null 2>&1; then
    compdef '_dispatch redis-cli_completion redis-cli' valkey-cli
fi

# load bash completion
autoload -U +X bashcompinit
bashcompinit

if command -v register-python-argcomplete 1>/dev/null 2>&1; then
    # pipx
    if command -v pipx 1>/dev/null 2>&1; then
        source <(register-python-argcomplete pipx)
    fi
fi

# terraform
if command -v terraform 1>/dev/null 2>&1; then
    complete -o nospace -C terraform terraform
fi

# azure-cli
[[ -d "${HOME}/.azure-cli" ]] || mkdir "${HOME}/.azure-cli"
if [[ ! -f "${HOME}/.azure-cli/az.completion" ]]; then
    curl -o "${HOME}/.azure-cli/az.completion" https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion
fi
source "${HOME}/.azure-cli/az.completion"

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
alias gt='gitui'

########################################
# Tools
# zoxide
if command -v zoxide 1>/dev/null 2>&1; then
    eval "$(zoxide init --cmd j zsh)"
fi

# yazi
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# tmux
if ! command -v tmux 1>/dev/null 2>&1 || ! command -v fzf 1>/dev/null 2>&1; then
    exit
fi
if [[ -z "${TMUX}" && ! -z "${PS1}" && "${TERM_PROGRAM}" != "vscode" ]]; then
    local sessions="$(tmux list-sessions 2>/dev/null)"
    if [[ -z "${sessions}" ]]; then
        tmux new-session
    else
        local new_session="Create New Session"
        local finder_sessions="${sessions}\n${new_session}:"
        local id="$(echo ${finder_sessions} | fzf | cut -d: -f1)"
        if [[ "${id}" = "${new_session}" ]]; then
            tmux new-session
        elif [[ -n "${id}" ]]; then
            tmux attach-session -t "${id}"
        fi
    fi
fi


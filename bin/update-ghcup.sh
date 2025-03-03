#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** ghcup updating... *****'

if ! command -v ghcup 1>/dev/null 2>&1; then
    printf "${ESC}[1;31m%s${ESC}[m\n" '***** ghcup NOT installed. *****'
    exit 1
fi

(ghcup upgrade &&
    ghcup install ghc latest &&
    ghcup install hls latest &&
    ghcup install stack latest &&
    curl -o "${HOME}/.zfunc/_ghcup" https://raw.githubusercontent.com/haskell/ghcup-hs/master/scripts/shell-completions/zsh &&
    printf "${ESC}[1;32m%s${ESC}[m\n" '***** ghcup updated (If you want to use latest: ghcup set ghc|hls|stack [version]). *****' &&
    exit 0) ||
    (printf "${ESC}[1;31m%s${ESC}[m\n" '***** ghcup update failed. *****' &&
        exit 2)

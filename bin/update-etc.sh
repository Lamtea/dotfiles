#!/bin/bash

ESC=$(printf '\033')

# ghcup completion
printf "${ESC}[1;36m%s${ESC}[m\n" '***** ghcup completion updating... *****'

(curl -o "${HOME}/.zfunc/_ghcup" https://raw.githubusercontent.com/haskell/ghcup-hs/master/scripts/shell-completions/zsh &&
    printf "${ESC}[1;32m%s${ESC}[m\n" '***** ghcup completion updated. *****' &&
    exit 0) ||
    (printf "${ESC}[1;31m%s${ESC}[m\n" '***** ghcup completion update failed. *****' &&
        exit 2)

# azure-cli completion
printf "${ESC}[1;36m%s${ESC}[m\n" '***** azure-cli completion updating... *****'

(curl -o "${HOME}/.azure-cli/az.completion" https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion &&
    printf "${ESC}[1;32m%s${ESC}[m\n" '***** azure-cli completion updated. *****' &&
    exit 0) ||
    (printf "${ESC}[1;31m%s${ESC}[m\n" '***** azure-cli completion update failed. *****' &&
        exit 2)

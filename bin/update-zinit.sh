#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** zinit updating... *****'

if [[ ! -d "${HOME}/.local/share/zinit/zinit.git" ]]; then
    printf "${ESC}[1;31m%s${ESC}[m\n" '***** zinit NOT installed. *****'
    exit 1
fi

(zsh -c 'source ~/.zshrc && zinit update' &&
    printf "${ESC}[1;32m%s${ESC}[m\n" '***** zinit updated. *****' &&
    exit 0) ||
    (printf "${ESC}[1;31m%s${ESC}[m\n" '***** zinit failed. *****' &&
        exit 2)

#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** php composer updating... *****'

if ! command -v composer 1>/dev/null 2>&1; then
    printf "${ESC}[1;31m%s${ESC}[m\n" '***** php compser NOT installed. *****'
    exit 1
fi

(cd "${HOME}" &&
    composer update &&
    printf "${ESC}[1;32m%s${ESC}[m\n" '***** php composer updated. *****' &&
    exit 0) ||
    (printf "${ESC}[1;31m%s${ESC}[m\n" '***** php composer update failed. *****' &&
        exit 2)

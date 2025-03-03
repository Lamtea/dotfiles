#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** mise updating... *****'

if ! command -v mise 1>/dev/null 2>&1; then
    printf "${ESC}[1;31m%s${ESC}[m\n" '***** mise NOT installed. *****'
    exit 1
fi

(mise self-update -y -C "${HOME}" &&
    mise upgrade -y -C "${HOME}" &&
    printf "${ESC}[1;32m%s${ESC}[m\n" '***** mise updated. *****' &&
    exit 0) ||
    (printf "${ESC}[1;31m%s${ESC}[m\n" '***** mise update failed. *****' &&
        exit 2)

#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** ruby bundle updating... *****'

if ! command -v bundle 1>/dev/null 2>&1; then
    printf "${ESC}[1;31m%s${ESC}[m\n" '***** ruby bundle NOT installed. *****'
    exit 1
fi

(cd "${HOME}" &&
    bundle install &&
    printf "${ESC}[1;32m%s${ESC}[m\n" '***** ruby bundle updated. *****' &&
    exit 0) ||
    (printf "${ESC}[1;31m%s${ESC}[m\n" '***** ruby bundle update failed. *****' &&
        exit 2)

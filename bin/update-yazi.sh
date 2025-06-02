#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** yazi packages updating... *****'

if ! command -v ya 1>/dev/null 2>&1; then
    printf "${ESC}[1;31m%s${ESC}[m\n" '***** yazi NOT installed. *****'
    exit 1
fi

(ya pkg upgrade &&
    printf "${ESC}[1;32m%s${ESC}[m\n" '***** yazi packages updated. *****' &&
    exit 0) ||
    (printf "${ESC}[1;31m%s${ESC}[m\n" '***** yazi packages failed. *****' &&
        exit 2)

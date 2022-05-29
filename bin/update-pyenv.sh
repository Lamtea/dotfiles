#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** pyenv updating... *****'

if ! command -v pyenv 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** pyenv NOT installed.*****'
	exit 1
fi

pyenv update &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** pyenv updated. *****.' &&
	exit 0 ||
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** pyenv update failed. *****' &&
	exit 2

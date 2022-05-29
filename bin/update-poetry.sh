#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** poetry updating... *****'

if ! command -v poetry 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** poetry NOT installed. *****'
	exit 1
fi

poetry self update &&
	poetry completions zsh >~/.zfunc/_poetry &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** poetry updated. *****.' &&
	exit 0 ||
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** poetry update failed. *****' &&
	exit 2

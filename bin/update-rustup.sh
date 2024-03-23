#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** rustup updating... *****'

if ! command -v rustup 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** rustup NOT installed. *****'
	exit 1
fi

(rustup self update &&
	rustup update &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** rustup updated. *****' &&
	exit 0) ||
	(printf "${ESC}[1;31m%s${ESC}[m\n" '***** rustup update failed. *****' &&
		exit 2)

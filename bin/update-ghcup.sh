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
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** ghcup updated. *****.' &&
	exit 0) ||
	(printf "${ESC}[1;31m%s${ESC}[m\n" '***** ghcup update failed. *****' &&
		exit 2)

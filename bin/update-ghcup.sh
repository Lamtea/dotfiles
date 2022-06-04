#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** ghcup updating... *****'

if ! command -v ghcup 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** ghcup NOT installed. *****'
	exit 1
fi

(ghcup install ghc latest &&
	ghcup set ghc latest &&
	ghcup install stack latest &&
	ghcup set stack latest &&
	stack install haskell-dap ghci-dap haskell-debug-adapter fourmolu &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** ghcup updated. *****.' &&
	exit 0) ||
	(printf "${ESC}[1;31m%s${ESC}[m\n" '***** ghcup update failed. *****' &&
		exit 2)

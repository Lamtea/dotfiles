#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** asdf golangci-lint updateting... *****'

if ! command -v asdf 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf NOT installed.*****'
	exit 1
fi

PLUGIN="$(asdf plugin-list | grep 'golangci-lint' 2>/dev/null)"
if [[ -z "$PLUGIN" ]]; then
	if asdf plugin-add golangci-lint; then
		printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf golangci-lint plugin installed. *****'
	else
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf golangci-lint plugin install failed. *****'
		exit 2
	fi
fi

asdf install golangci-lint latest &&
	asdf global golangci-lint "$(asdf list golangci-lint | grep '[0-9]\+' | tail -n 1 | xargs)" &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf golangci-lint updated. *****.' &&
	exit 0 ||
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf golangci-lint update failed. *****' &&
	exit 3

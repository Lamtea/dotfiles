#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** asdf dotnet-core updating... *****'

if ! command -v asdf 1>/dev/null 2>&1; then
	printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf NOT installed. *****'
	exit 1
fi

PLUGIN="$(asdf plugin-list | grep 'dotnet-core' 2>/dev/null)"
if [[ -z "$PLUGIN" ]]; then
	if asdf plugin-add dotnet-core; then
		asdf global dotnet-core system
		printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf dotnet-core plugin installed (and set: asdf global dotnet-core system). *****'
	else
		printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf dotnet-core plugin install failed. *****'
		exit 2
	fi
fi

(asdf install dotnet-core latest &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** asdf dotnet-core updated (If you want to use latest: asdf local dotnet-core [version]). *****.' &&
	exit 0) ||
	(printf "${ESC}[1;31m%s${ESC}[m\n" '***** asdf dotnet-core update failed. *****' &&
		exit 3)

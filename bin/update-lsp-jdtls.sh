#!/bin/bash

ESC=$(printf '\033')
printf "${ESC}[1;36m%s${ESC}[m\n" '***** jdtls updating... *****'

if [[ -d $HOME/dev/lsp/jdtls ]]; then
	rm -rf ~/dev/lsp/jdtls ||
		(printf "${ESC}[1;31m%s${ESC}[m\n" '***** ~/dev/lsp/jdtls could NOT be removed. *****' &&
			exit 1)
fi

(mkdir -p ~/dev/lsp/jdtls &&
	cd ~/dev/lsp/jdtls &&
	wget https://download.eclipse.org/jdtls/snapshots/latest.txt -O latest.txt &&
	wget https://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz -O latest.tar.gz &&
	tar -zxvf latest.tar.gz &&
	printf "${ESC}[1;32m%s${ESC}[m\n" '***** jdtls updated. *****.' &&
	exit 0) ||
	(printf "${ESC}[1;31m%s${ESC}[m\n" '***** jdtls update failed. *****' &&
		exit 3)

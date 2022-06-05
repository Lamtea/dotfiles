#!/bin/bash

update-asdf.sh &&
	update-dotnet-core-tools.sh &&
	update-pyenv.sh &&
	update-poetry.sh &&
	update-ghcup.sh &&
	update-rustup.sh &&
	update-vscode.sh &&
	update-lsp.sh

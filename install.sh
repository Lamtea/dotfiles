#!/bin/bash

# nounset, errexit
set -ue

create_dotfile_links() {
	local dotfiles_or_dirs=("${@}")

	local srcdir
	srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

	local dotbackupdir="${HOME}/.dotbackup"
	if [[ ! -d "${dotbackupdir}" ]]; then
		mkdir "${dotbackupdir}"
	fi

	for dotfile_or_dir in "${dotfiles_or_dirs[@]}"; do
		local srcfile_or_dir="${srcdir}/${dotfile_or_dir}"
		local dstfile_or_dir="${HOME}/${dotfile_or_dir}"
		local backupfile_or_dir="${dotbackupdir}/${dotfile_or_dir}"

		local dstdir
		local backupdir
		dstdir="$(dirname "${dstfile_or_dir}")"
		backupdir="$(dirname "${backupfile_or_dir}")"

		if [[ -e "${dstfile_or_dir}" && ! -L "${dstfile_or_dir}" ]]; then
			if [[ ! -e "${backupdir}" ]]; then
				mkdir -p "${backupdir}"
			fi
			mv "${dstfile_or_dir}" "${backupdir}"
		fi

		if [[ ! -e "${dstdir}" ]]; then
			mkdir -p "${dstdir}"
		fi
		ln -snf "${srcfile_or_dir}" "${dstfile_or_dir}"
	done
}

dotfiles_or_dirs=(
	.zprofile
	.zshrc
	.zshenv
	.tmux.conf
	.gitconfig
	.default-gems
	.default-golang-pkgs
	.default-npm-packages
	.default-python-packages
	.config/nvim
	.config/neomutt
	.config/ranger
	.bin/rclone_mount.sh
	bin/update-devtools.sh
	bin/update-asdf.sh
	bin/update-asdf-self.sh
	bin/update-asdf-globals.sh
	bin/update-asdf-neovim.sh
	bin/update-asdf-ruby.sh
	bin/update-asdf-golangci-lint.sh
	bin/update-asdf-hadolint.sh
	bin/update-asdf-ktlint.sh
	bin/update-asdf-locals.sh
	bin/update-asdf-nodejs.sh
	bin/update-asdf-deno.sh
	bin/update-asdf-golang.sh
	bin/update-asdf-dotnet-core.sh
	bin/update-dotnet-core-tools.sh
	bin/update-pyenv.sh
	bin/update-poetry.sh
	bin/update-ghcup.sh
	bin/update-rustup.sh
	bin/update-vscode.sh
	bin/update-vscode-node-debug2.sh
	bin/update-vscode-chrome-debug.sh
	bin/update-vscode-firefox-debug.sh
	bin/update-vscode-php-debug.sh
	bin/update-java-debug.sh
	bin/update-vscode-java-test.sh
	bin/update-lsp.sh
	bin/update-lsp-jdtls.sh
	bin/update-lsp-lombok.sh
	Gemfile
)

create_dotfile_links "${dotfiles_or_dirs[@]}"

## neomutt mutt compatibility setting
ln -snf "${HOME}/.config/neomutt/neomuttrc" "${HOME}/.muttrc"

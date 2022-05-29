#!/bin/bash

# シェルオプション
# nounset, errexit
set -ue

# リンク作成関数
create_dotfile_links() {
	# 設定ファイルリスト(ディレクトリ指定も可能)
	local dotfiles_or_dirs=("${@}")

	# リンク元のデイレクトリ取得
	local srcdir
	srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

	# バックアップディレクトリ作成
	local dotbackupdir="${HOME}/.dotbackup"
	if [[ ! -d "${dotbackupdir}" ]]; then
		mkdir "${dotbackupdir}"
	fi

	# リンク作成実行
	for dotfile_or_dir in "${dotfiles_or_dirs[@]}"; do
		# リンク元, リンク先, バックアップ先ファイル名(ディレクトリ名)
		local srcfile_or_dir="${srcdir}/${dotfile_or_dir}"
		local dstfile_or_dir="${HOME}/${dotfile_or_dir}"
		local backupfile_or_dir="${dotbackupdir}/${dotfile_or_dir}"

		# リンク先, バックアップ先の親ディレクトリ
		local dstdir
		local backupdir
		dstdir="$(dirname "${dstfile_or_dir}")"
		backupdir="$(dirname "${backupfile_or_dir}")"

		# ファイルが存在かつリンクでない場合, ファイル(ディレクトリ)のバックアップを行う
		if [[ -e "${dstfile_or_dir}" && ! -L "${dstfile_or_dir}" ]]; then
			if [[ ! -e "${backupdir}" ]]; then
				mkdir -p "${backupdir}"
			fi
			mv "${dstfile_or_dir}" "${backupdir}"
		fi

		# リンク作成
		if [[ ! -e "${dstdir}" ]]; then
			mkdir -p "${dstdir}"
		fi
		ln -snf "${srcfile_or_dir}" "${dstfile_or_dir}"
	done
}

# 設定ファイルリスト(ディレクトリ指定も可能)
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
	Gemfile
)

# リンク作成
create_dotfile_links "${dotfiles_or_dirs[@]}"

# 個別にリンク設定が必要なもの
## neomutt mutt互換設定
ln -snf "${HOME}/.config/neomutt/neomuttrc" "${HOME}/.muttrc"

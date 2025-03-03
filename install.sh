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
    .nirc
    .default-go-packages
    .default-npm-packages
    .default-python-packages
    .config/gitui
    .config/mise
    .config/nvim/init.lua
    .config/nvim/lua
    .config/nvim/ftplugin
    .config/neomutt
    .config/yazi/init.lua
    .config/yazi/keymap.toml
    .config/yazi/theme.toml
    .config/yazi/yazi.toml
    .config/irb/irbrc
    .bin/rclone_mount.sh
    bin/update-devtools.sh
    bin/update-mise.sh
    bin/update-rustup.sh
    bin/update-ghcup.sh
    bin/update-ruby-bundle.sh
    bin/update-php-composer.sh
    bin/update-etc.sh
    bin/update-yazi.sh
    bin/update-zinit.sh
    composer.json
    Gemfile
)

create_dotfile_links "${dotfiles_or_dirs[@]}"

## neomutt mutt compatibility setting
ln -snf "${HOME}/.config/neomutt/neomuttrc" "${HOME}/.muttrc"

# dotfiles

My dotfiles for command-line interface on Arch linux.

## Overview

![overview](https://user-images.githubusercontent.com/48638671/171588449-9a133364-cb2b-4423-a661-0510a0940431.png)

## How to Install

gnome-keyring settings required.

See: [Wiki](https://github.com/Lamtea/dotfiles/wiki/gnome-keyring)

```bash
# Install arch official packages and aur packages(see below `Depend on` list).
# Options can be ignored.
# If you want to use cloud such as dropbox, gdrive, etc..,
# setup rclone(see: Arch wiki) and edit ./bin/rclone_mount.sh.
# (In my case run on i3 startup)
# nginx is used to check debugging using pathmappings, for example in PHP (even docker).
# ranger is a vim-like filer.
# Use neomutt and postfix in local mail delivery(See Arch wiki for postfix settings).
# (In my case I use it to logwatch and notify system errors from services.)
# (Also, it is not used in wsl.)
yay -S <dependent packages>
```

```bash
cd ~
# If you fail, make sure the way may have changed(see: github).
git clone --depth 1 https://github.com/wbthomason/packer.nvim .local/share/nvim/site/pack/packer/start/packer.nvim
git clone https://github.com/Lamtea/dotfiles.git .dotfiles
```

```bash
cd .dotfiles
vi .gitconfig
  email = <your email address>
  name = <your user name>
# For localization, see below `Localization`.
vi .config/neomutt/neomuttrc
  set my_name="<your name>"
```

```bash
./install.sh
```

```bash
# Install zsh plugins and some packages from github or script.
# If you are not using zsh, run `chsh -s /usr/bin/zsh'.
exec zsh
```

```bash
# Install mise tools, rustup, ghcup, ruby bundle, dotnet tools, etc...
# If you fail, make sure the way may have changed(See: github).
~/bin/update-devtools.sh
source ~/.zshrc
```

```bash
# Install neovim plugins and create helptags,
# and install lsp, dap in your programming languages
# (if you are unsure, see below `neovim Plugins, LSP, DAP` list).
# Finally, All OK except WARNING from Whichkey.
# (No problem because it is an extension of the standard command)
vi +PackerSync
   :helptags ALL
   :Mason
   :checkhealth
```

## Container **(optional)**

### Docker

See: [Arch Wiki - Docker](https://wiki.archlinux.org/title/Docker)

### Containerd

See: [gitHub - containerd](https://github.com/containerd/containerd)

See: [gitHub - nerdctl](https://github.com/containerd/nerdctl)

## Kubernetes **(optional)**

### Minikube

See: [Arch Wiki - Minikube](https://wiki.archlinux.org/title/Minikube)

### Kind

See: [github - kind](https://github.com/kubernetes-sigs/kind)

## Neovim

### Neovim Plugins, LSP, DAP

See: [Wiki](https://github.com/Lamtea/dotfiles/wiki/neovim#introduction)

### Neovim Hello World

See: [Wiki](https://github.com/Lamtea/dotfiles/wiki/neovim#hello-world)

## Depend on

### Official

- actionlint
- android-tools
- android-udev
- aspnet-runtime
- aspnet-targeting-pack
- azure-cli
- base-devel
- bemenu
- buf
- certbot
  - certbot-nginx **(optional)**
  - certbot-dns-cloudflare
- clang
- cmake
- codespell
- composer
- containerd **(optional)**
  - nerdctl
  - buildkit
  - cni-plugins
  - rootlesskit
  - slir4netns
- colordiff
- cppcheck
- dart-sass
- delve
- docker **(optional)**
  - docker-buildx
  - docker-compose
- dotnet-host
- dotnet-runtime
- dotnet-sdk
- dotnet-targeting-pack
- editorconfig-checker
- fd
- fzf
- gawk
- git
- github-cli
- gitui
- gnome-keyring
  - libsecret
- go
- gradle
- imagemagick
- jdk-openjdk
- jdk11-openjdk
- jdk17-openjdk
- jq
- lldb
- lua
- luacheck
- luarocks
- markdownlint-cli2
- maven
- minikube **(optional)**
  - argocd
  - istio
  - kubernetes-tools
  - helm
  - helmfile
- neomutt **(optional)**
- neovim
  - python-pynvim
- nginx **(optional)**
- ninja
- nodejs-lts-iron
- npm
- npm-check-updates
- openssh
- php
- php-\* (apcu, gd, sqlite, pgsql, redis, imagick, fpm)
- pnpm
- postfix **(optional)** _(localhost only for neomutt)_
- prettier
- protobuf
- python3
- python-build
- python-debugpy
- python-pytest
- ranger **(optional)**
- rclone **(optional)**
  - gdrive
  - dropbox
  - onedrive
  - pcloud
  - mega
- ripgrep
- ruff
- rust
- shfmt
- shellcheck
- source-highlight
- stylua
- sqlfluff
- sqlite
- taplo-cli
- terraform
- tidy
- tmux
- tree-sitter-cli
- w3m
- wget
- xclip
  **(optional)**
  _(I use Linux Desktop Environment so this is it, see `:h clipboard` in nvim)_
- xdebug
- yamllint
- yarn
- zsh

### AUR

- android-apktool
- azcopy
- azure-developer-cli
- azure-functions-core-tools
- bashdb
- checkmake
- cmake-language-server
  - cmake-format
- devcontainer-cli
- debtap
- nvidia-container-toolkit **(optional)** _(for NVIDIA CUDA user, also available in containerd)_
- google-java-format
- neovim-drop-in
- nodejs-neovim
- php-cs-fixer
- yay

### From install script

- ghcup
  - ghc
  - hls
  - stack
    - haskell-debug-adapter
      - haskell-dap
      - ghci-dap
    - hlint
      - apply-refact
    - fourmolu
- mise
  - bun _(global, latest)_
  - dart _(global, latest)_
  - deno _(global, latest)_
  - dotnet _(global, latest)_
  - flutter _(global, latest)_
  - golang _(local)_
    - delve
  - golangci-lint _(global, latest)_
  - hadolint _(global, latest)_
  - java _(local)_
  - kind _(global, latest)_
  - kotlin _(global, latest)_
  - ktlint _(global, latest)_
  - neovim _(global, stable)_
    - wbthomason/packer.nvim
  - nodejs _(local)_
    - devcontainers/cli
    - markdownlint-cli2
    - neovim
    - npm-check-updates
    - pnpm
    - prettier
  - poetry _(global, latest)_
  - python _(local)_
    - debugpy
    - neovim
  - ruby _(global, latest)_
    - bundler
  - rye (global, latest)
  - tfsec _(global, latest)_
- rustup
  - cargo
  - clippy
  - llvm-tools
  - rls
  - rust-analysis
  - rust-analyzer
  - rust-docs
  - rust-src
  - rust
  - rustc
  - rustfmt

## Localization

- Edit `.zshrc`
  - `export LANG=ja_JP.UTF-8` # change your locale
- Edit `.config/nvim/lua/plugins/sidebar.lua`
  - `datetime` section
    - `format = "%b %d日 (%a) %H:%M"` # change your locale
- There is **fcitx5** setting in `.config/nvim/lua/command.lua`
  - It works installed _(it won't work unless)_.
    - If you are ibus user, edit to your setting.

## Terminal Fonts for zsh powerlevel10k

- For Japanese
  - HackGen Console NF
  - MesloLGS NF

## Scripts

| Name            | Description                   |
| --------------- | ----------------------------- |
| rclone_mount.sh | mount cloud script.           |
| update-\*.sh    | update local package scripts. |

## Develop Environment

- bash
- zsh
- python
- lua
- git
- neovim

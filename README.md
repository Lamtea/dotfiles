# dotfiles

My dotfiles for command-line interface on Arch linux.

## Overview

![overview](https://user-images.githubusercontent.com/48638671/171588449-9a133364-cb2b-4423-a661-0510a0940431.png)

## How to Install

gnome-keyring settings required.

See: [Wiki](https://github.com/Lamtea/dotfiles/wiki/gnome-keyring)

```bash
# Install arch packages and aur packages(see below `Depend on` list).
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
# Install mise tools, poetry, rustup, ghcup, ruby bundle, dotnet tools.
# If you fail, make sure the way may have changed(See: github).
~/bin/update-devtools.sh
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

## Containers **(optional)**

### Docker

See: [Arch Wiki - Docker](https://wiki.archlinux.org/title/Docker)

### Containerd

See: [gitHub - containerd](https://github.com/containerd/containerd)

See: [gitHub - nerdctl](https://github.com/containerd/nerdctl)

### Minikube

See: [Arch Wiki - Minikube](https://wiki.archlinux.org/title/Minikube)

### Kind

See: [github - kind](https://github.com/kubernetes-sigs/kind)

## Neovim Plugins, LSP, DAP

See: [Wiki](https://github.com/Lamtea/dotfiles/wiki/neovim#introduction)

## Neovim Hello World

See: [Wiki](https://github.com/Lamtea/dotfiles/wiki/neovim#hello-world)

## Depend on

### Official

- android-tools
- android-udev
- aspnet-runtime
- aspnet-targeting-pack
- base-devel
- bemenu
- buf
- certbot
  - certbot-nginx **(optional)**
  - certbot-dns-cloudflare
- clang
- cmake
- codespell _(spell linter/formatter)_
- composer
- containerd **(optional)**
  - nerdctl
  - buildkit
  - cni-plugins
  - rootlesskit
  - slir4netns
- colordiff
- cppcheck _(c/cpp linter)_
- dart-sass
- delve _(go debugger)_
- deno
- docker **(optional)**
  - docker-buildx
  - docker-compose
- dotnet-host
- dotnet-runtime
- dotnet-sdk
- dotnet-targeting-pack
- editorconfig-checker _(editorconfig linter)_
- fd
- flake8 _(python linter)_
- fzf
- gawk
- git
- github-cli
- gnome-keyring
  - libsecret
- go
- gradle
- imagemagick
- jdk-openjdk
- jdk11-openjdk
- jdk17-openjdk
- julia
- kotlin
- lldb _(c/cpp/rust debugger)_
- lua
- luacheck _(lua linter)_
- luarocks
- markdownlint-cli2 _(markdown linter)_
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
- nodejs-lts-hydrogen
- npm
- npm-check-updates
- openssh
- php
- php-\* (apcu, gd, sqlite, pgsql, redis, imagick, fpm)
- postfix **(optional)** _(localhost only for neomutt)_
- prettier
  _(html/css/sass/javascript/typescript/react/vue/json/yaml/markdown/graphql formatter)_
- protobuf
- python3
- python-black _(python formatter)_
- python-debugpy _(python debugger)_
- python-isort _(python formatter)_
- python-pytest
- ranger **(optional)**
- rclone **(optional)**
  - gdrive
  - dropbox
  - onedrive
  - pcloud
  - mega
- ripgrep
- rust
- shfmt _(bash formatter)_
- shellcheck _(bash linter)_
- source-highlight
- stylua _(lua formatter)_
- sqlfluff _(sql linter/formatter)_
- sqlite
- terraform
- tidy _(html/xml linter)_
- tmux
- tree-sitter-cli
- w3m
- wget
- xclip
  **(optional)**
  _(I use Linux Desktop Environment so this is it, see `:h clipboard` in nvim)_
- xdebug _(php debugger extension)_
- yarn
- zsh

### AUR

- android-apktool
- android-platform
- android-sdk
- android-sdk-build-tools
- android-sdk-cmdline-tools-latest
- android-sdk-platform-tools
- azure-cli
- azure-functions-core-tools
- bashdb _(bash debugger)_
- checkmake _(make linter)_
- cmake-language-server _(cmake linter/formatter)_
- devcontainer-cli
- debtap
- nvidia-container-toolkit **(optional)** _(for NVIDIA CUDA user, also available in containerd)_
- google-java-format _(java formatter)_
- grpcurl-bin
- kind-bin **(optional)**
- neovim-drop-in _(vi/vim simlink)_
- nodejs-neovim
- nodejs-jsonlint _(json linter)_
- php-cs-fixer _(php formatter)_
- yay

### From install script

- ghcup
  - ghc
  - hls
  - stack
    - haskell-debug-adapter _(haskell debugger)_
      - haskell-dap
      - ghci-dap
    - hlint _(haskell linter)_
      - apply-refact
    - fourmolu _(haskell formatter)_
- mise
  - actionlint _(global, latest, github actions linter)_
  - dart _(global, latest)_
  - deno _(local)_
  - dotnet _(global, latest)_
  - flutter _(global, latest)_
  - golang _(local)_
    - delve
  - golangci-lint _(global, latest, go linter)_
  - hadolint _(global, latest, dockerfile linter)_
  - ktlint _(global, latest, kotlin linter/formatter)_
  - neovim _(global, stable)_
    - wbthomason/packer.nvim
  - nodejs _(local)_
    - devcontainers/cli
    - markdownlint-cli2
    - neovim
    - npm-check-updates
    - prettier
  - python _(local)_
    - debugpy
    - neovim
  - ruby _(global, latest)_
    - bundler
  - tfsec _(global, latest, terraform linter)_
- poetry
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
  - Ricty & MesloLGS NF
  - HackGenNerd

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

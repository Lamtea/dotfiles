# dotfiles

My dotfiles for command line interface on Arch linux.

## How to install

Run this command: `install.sh`

## Depend on

- asdf(from git clone, see: gitHub)
  - deno(asdf)
  - dotnet(asdf)
  - golang(asdf)
  - golangci-lint(asdf)
  - nodejs(asdf)
    - editorconfig-checker(npm)
    - eslint(npm)
    - jsonlint(npm)
    - markdownlint-cli(npm)
    - postcss(npm)
    - prettier(npm)
    - sass(npm)
    - stylelint(npm)
    - tidy(npm)
    - typescript(npm)
    - webpack(npm)
    - yaml-lint(npm)
  - ruby(asdf)
    - readapt(bundle)
    - rails(bundle)
    - rubocop(bundle)
- aspnet-runtime
- aspnet-targeting-pack
- bashdb
- bemenu
- clang
- cmake
- codespell(spell linter/formatter)
- composer
- colordiff
- cppcheck(c/cpp linter)
- dart
- dart-sass
- delve(go debugger)
- deno
- dotnet-host
- dotnet-runtime
- dotnet-sdk
- dotnet-targeting-pack
- editorconfig-checker(editorconfig linter)
- fd
- flake8(python linter)
- fzf
- gawk
- ghcup-hs-bin
  - ghc(ghcup)
  - stack(ghcup)
    - haskell-dap(stack, haskell debugger)
    - ghci-dap(stack, haskell debugger)
    - haskell-debug-adapter(stack, haskell debugger)
    - fourmolu(stack, haskell formatter)
- github-cli
- gnome-keyring
- go
- golangci-lint(go linter)
- hadolint-bin(dockerfile linter)
- jdk-openjdk
- julia
- kotlin
- ktlint(kotlin linter/formatter)
- libgnome-keyring
- lldb(c/cpp/rust debugger)
- luacheck(lua linter)
- neomutt
- neovim
  - neovim-drop-in(vi/vim simlink)
  - nodejs-neovim
  - python-pynvim
  - ruby-neovim
  - wbthomason/packer.nvim(from install script, see: gitHub)
- nodejs-jsonlint(json linter)
- nodejs-lts-gallium
- nodejs-markdownlint-cli(markdown linter)
- npm
- openssh
- php
- php-cs-fixer(php formatter)
- poetry(from install script, see: python-poetry.org)
- postfix(localhost only for neomutt)
- prettier(multiple formatter)
- pyenv(from install script, see: gitHub)
  - python3(pyenv)
    - black(poetry)
    - debugpy(poetry)
    - flake8(poetry)
    - isort(poetry)
- python3
- python-black(python formatter)
- python-debugpy(python debugger)
- python-isort(python formatter)
- python-pip
- ranger
- rclone
  - gdrive
  - dropbox
  - onedrive
  - pcloud
  - mega
- ripgrep
- ruby
- ruby-bundler
  cd ~/
  bundle config set --local path 'vendor/bundle'
  vi GemFile (add 'gem readapt')
  bundle install
  - readapt(ruby debugger)
- rubygems
  - rubocop(ruby linter/formatter)
- rustup(from install script, see: www.rust-lang.org)
  - rust(rustup)
  - cargo(rustup)
- shfmt(bash formatter)
- shellcheck(bash linter)
- source-highlight
- stylelint(css linter)
- stylelint-config-standard
- stylua(lua formatter)
- sqlfluff(sql linter/formatter)
- sqlite
- tidy(html linter)
- tmux
- typescript
- w3m
- wget
- xclip
- zsh

## Terminal fonts for zsh powerlevel10k

- Ricty & MesloLGS NF
- HackGenNerd

## Shell scripts

| Name            | Description         |
| --------------- | ------------------- |
| rclone_mount.sh | mount cloud script. |

## Development

- bash
- bashdb
- python
- lua
- git
- nodejs
  - bash-language-server
- vscode
- neovim

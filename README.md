# Qingshan's Dotfiles

Dotfiles are for macOS and Linux to setup my development environment.

## Installation

```shell
git clone https://github.com/qingshan/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make
```

## Features

### Desktops

- [macOS](macos/README.md)
- [Debian](debian/README.md): regolith-i3 & xremap & xmodmap

Both desktops use same key bindigs, go to [Desktop Cheatsheet](docs/desktop_cheatsheet.md).

### Servers

- Debian
- Ubuntu
- Rocky Linux

### Terminals

- alacritty
- tmux

For key bindings, go to [Terminal Cheatsheet](https://qingshan.dev/posts/alacritty-integration-with-tmux/)

### Shells

- fish

### Tools

- bat
- fd
- lsd
- fzf
- direnv
- ripgrip
- starship
- gh
- lazygit
- zoxide
- jq
- just

### Notes

- mdbook for publish notes

### Development Environments

- Java: IntelliJ IDEA Community Edition with IdeaVim
- Rust: Zed

### Fonts

- JetBrains Mono Font
- Nerd Font

### Vim
- [Vim Cheatsheet](docs/vim_cheatsheet.md)
- [Vim Plugins](docs/vim_plugins.md)
- [IdeaVim](docs/ideavim.md)

## Test

It uses Docker on Linux or Apple container to build `linux/debian/Dockkerfile` to test dotfiles on latest version of Debian.

```shell
make test
```

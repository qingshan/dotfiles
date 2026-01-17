# Qingshan's Dotfiles

Dotfiles are for macOS and Linux to setup my development environment.

## Installation

Install dotfiles, run:

```shell
git clone https://github.com/qingshan/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make
```

For macOS or Debian desktop, one more step:

```shell
make desktop
```

## Demos

Terminal shortcuts:
![demo alacritty shortcuts](https://qingshan.dev/images/demo_alacritty_shortcuts.gif)

## Features

### Desktops

- [macOS](macos/README.md)
- [Debian](debian/README.md): regolith-i3 & xremap & xmodmap

Both desktops use same key bindings, go to [Desktop Cheatsheet](docs/desktop_cheatsheet.md).

### Servers

- Debian, Ubuntu
- Rocky Linux, CentOS, RedHat Enterprise Linux
- Arch Linux

### Shells

zsh as default shell on macOS:
- `~/.zprofile` and `~/.profile` is sourced in login shell.
- `~/.zshrc` is sourced in interactive shell.

bash as default shell on macOS:
- `~/.bash_profile` and `~/.profile` is sourced in login shell.
- `~/.bashrc` is sourced in interactive shell.

fish as interactive shell in interactive mode of zsh or bash, without setting it as user's default shell.

so update `~/.profile` for user environment which will be available for all shells.

### Fish Shell and Tools

Fish shell integration with:
- starship
- fzf
- zoxide
- direnv
- lsd
- bat
- fd
- ripgrip
- jq
- just
- functions
- aliases
- abbreviations
- bash scripts

### Terminals

- alacritty, ghostty, ssh runs user's default shell as interactive login shell.
- tmux runs inside an existing shell session, runs fish as interactive non-login shell.

alacritty as default terminal integrated with tmux, use iTerm2-like key bindings. go to [Terminal Cheatsheet](https://qingshan.dev/posts/alacritty-integration-with-tmux/) for key bindings.

ghosttty as quick terminal.

Tmux supercharges development workflow:
- key bindings
- menu
- launcher
- popup

### SSH

- `ssh server` starts interactive login shell.
- `ssh server command` non-interactive non-login shell.
- `echo command | ssh server` starts non-interactive login shell. You can also start one with `ssh server bash -l -c command`.

### Development Environments

Languages:
- Java: ant, maven
- Python: uv
- Node.js

IDE:
- IntelliJ IDEA with IdeaVim for Java
- Zed for Rust and Python

Containers:
- Apple Container
- Docker

Version Control:
- Git
- LazyGit
- Github CLI

### AI

- Google Gemini CLI
- Github Copilot CLI
- Claude Code

### Fonts

- JetBrains Mono Nerd Font

### Notes

- zk for cli notes: journal/inbox/notes
- Obsidian for tech notes
- Apple Notes for personal notes
- mdbook for publish notes: [qingshan/notes](https://github.com/qingshan/notes)

### Folders

- `~/work` for work projects.
- `~/code` for personal projects.
- `~/Documents` for cloud sync documents.
- `~/Public` for local grouped resources.

### Vim

- [Vim Cheatsheet](docs/vim_cheatsheet.md)
- [Vim Plugins](docs/vim_plugins.md)
- [IdeaVim](docs/ideavim.md)

## Test

Use Docker on Linux or Apple container on macOS to build `linux/debian/Dockkerfile` to test dotfiles on latest version of Debian.

run server test
```shell
make server-test
```

or run desktop test
```shell
make deskop-test
```

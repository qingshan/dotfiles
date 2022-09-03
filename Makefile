GIT_NAME = Qingshan
GIT_MAIL = qs@qingshan.dev

OS := $(shell uname -s | tr A-Z a-z)

install: setup packages dotfiles

setup: $(OS)

darwin:
	@sh ./macos/setup.sh

linux:
	@if [ -f /etc/redhat-release ]; then sh ./linux/redhat/setup.sh; fi
	@if [ -f /etc/arch-release ]; then sh ./linux/arch/setup.sh; fi
	@if [ -f /etc/debian_version ]; then sh ./linux/debian/setup.sh; fi
	bash -c 'rm -rf /usr/local/go && curl -sL https://go.dev/dl/go1.19.linux-amd64.tar.gz | sudo tar -C /usr/local -xz'
	bash -c 'sh <(curl https://sh.rustup.rs -sSf) -y'
	rustup component add rust-src
	mkdir -p ~/.local/bin
	curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
	chmod +x ~/.local/bin/rust-analyzer

packages: python-packages node-packages rust-packages

python-packages:
	pip3 install powerline-status

node-packages:

rust-packages:

dotfiles: zsh powerline vim tmux git dirs

zsh:
	ln -vsf .dotfiles/.aliases ${HOME}/.aliases
	ln -vsf .dotfiles/.profile ${HOME}/.profile
	ln -vsf .dotfiles/.zshrc ${HOME}/.zshrc
	@sh ./scripts/zsh.sh

powerline:
	@sh ./scripts/powerline.sh

vim:
	ln -vsf .dotfiles/.vimrc ${HOME}/.vimrc
	@sh scripts/vim.sh

tmux:
	ln -vsf .dotfiles/.tmux.conf ${HOME}/.tmux.conf

git:
	git config --global user.name $(GIT_NAME)
	git config --global user.email $(GIT_MAIL)

dirs:
	@test -d ~/.bin || mkdir -v ~/.bin

.PHONY: darwin linux
.DEFAULT_GOAL := install

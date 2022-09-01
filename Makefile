GIT_NAME = Qingshan
GIT_MAIL = dev@qingshan.dev

OS := $(shell uname -s | tr A-Z a-z)

install: setup packages dotfiles

setup: $(OS)

darwin:
	@sh ./macos/setup.sh

linux:
	@if [[ -f /etc/redhat-release ]]; then\
		sh ./linux/redhat/setup.sh;\
	elif [[ -f /etc/arch-release ]]; then\
		sh ./linux/arch/setup.sh;\
	elif [[ -f /etc/debian_version ]]; then\
		sh ./linux/debian/setup.sh;\
	else\
		echo "Please use redhat/arch/debian based distribution.";\
	fi

packages: python-packages node-packages rust

python-packages:
	pip3 install powerline-status

node-packages:

rust:
	bash -c 'sh <(curl https://sh.rustup.rs -sSf) -y'

dotfiles: link zsh powerline vim tmux git dirs

zsh:
	ln -vsf ${PWD}/.aliases ${HOME}/.aliases
	ln -vsf ${PWD}/.profile ${HOME}/.profile
	ln -vsf ${PWD}/.zshrc ${HOME}/.zshrc
	@sh ./scripts/zsh.sh

powerline:
	@sh ./scripts/powerline.sh

vim:
	ln -vsf ${PWD}/.vimrc ${HOME}/.vimrc
	@sh scripts/vim.sh

tmux:
	ln -vsf ${PWD}/.tmux.conf ${HOME}/.tmux.conf

git:
	git config --global user.name $(GIT_NAME)
	git config --global user.email $(GIT_MAIL)

dirs:
	@test -d ~/.bin || mkdir -v ~/.bin

.PHONY: darwin linux
.DEFAULT_GOAL := install

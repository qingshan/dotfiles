GIT_NAME = Qingshan
GIT_MAIL = qs@qingshan.dev

OS := $(shell uname -s | tr A-Z a-z)

install: setup packages dotfiles

setup: $(OS)

darwin:
	sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

linux:
	@if [ -f /etc/redhat-release ]; then sh ./linux/redhat/setup.sh; fi
	@if [ -f /etc/arch-release ]; then sh ./linux/arch/setup.sh; fi
	@if [ -f /etc/debian_version ]; then sh ./linux/debian/setup.sh; fi
	touch ~/.hushlogin
	bash -c 'rm -rf /usr/local/go && curl -sL https://go.dev/dl/go1.19.linux-amd64.tar.gz | sudo tar -C /usr/local -xz'
	bash -c 'sh <(curl https://sh.rustup.rs -sSf) -y'

packages: python-packages node-packages rust-packages fish-packages

python-packages:

node-packages:

rust-packages:
	rustup component add rust-src
	rustup component add rust-analyzer

fish-packages:
	curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
	fish -c "fisher install oh-my-fish/theme-bobthefish"
	fish -c "fisher install jethrokuan/fzf"

dotfiles: fish zsh vim alacritty helix tmux git dirs

fish:
	ln -vsf ../../.dotfiles/fish/config.fish ${HOME}/.config/fish/config.fish

zsh:
	ln -vsf .dotfiles/.profile ${HOME}/.profile
	ln -vsf .dotfiles/.zshrc ${HOME}/.zshrc
	@sh ./scripts/zsh.sh

vim:
	ln -vsf .dotfiles/.vimrc ${HOME}/.vimrc
	@sh scripts/vim.sh

alacritty:
	ln -vsf ../.dotfiles/alacritty ${HOME}/.config/alacritty

helix:
	ln -vsf ../.dotfiles/helix ${HOME}/.config/helix
	ln -vsf ../.dotfiles/.dprint.json ${HOME}/.dprint.json

tmux:
	ln -vsf .dotfiles/.tmux.conf ${HOME}/.tmux.conf

git:
	git config --global user.name $(GIT_NAME)
	git config --global user.email $(GIT_MAIL)

dirs:
	@test -d ~/.bin || mkdir -v ~/.bin

.PHONY: darwin linux alacritty tmux fish helix
.DEFAULT_GOAL := install

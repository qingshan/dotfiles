GIT_NAME = Qingshan
GIT_MAIL = qs@qingshan.dev

OS := $(shell uname -s | tr A-Z a-z)

.PHONY: install
install: setup tools packages

.PHONY: setup
setup: $(OS)

.PHONY: darwin
darwin:
	sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

.PHONY: linux
linux:
	@if [ -f /etc/redhat-release ]; then sh ./linux/redhat/setup.sh; fi
	@if [ -f /etc/arch-release ]; then sh ./linux/arch/setup.sh; fi
	@if [ -f /etc/debian_version ]; then sh ./linux/debian/setup.sh; fi
	touch ~/.hushlogin
	bash -c 'rm -rf /usr/local/go && curl -sL https://go.dev/dl/go1.23.4.linux-amd64.tar.gz | sudo tar -C /usr/local -xz'
	bash -c 'sh <(curl https://sh.rustup.rs -sSf) -y'

.PHONY: packages
packages: python-packages node-packages rust-packages fish-packages

.PHONY: python-packages
python-packages:

.PHONY: node-packages
node-packages:

.PHONY: go-packages
go-packages:

.PHONY: rust-packages
rust-packages:
	rustup component add rust-src
	rustup component add rust-analyzer

.PHONY: fish-packages
fish-packages:
	fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
	fish -c "fisher install patrickf1/fzf.fish"
	fish -c "fisher install jorgebucaran/autopair.fish"

.PHONY: tools
tools: fish bash zsh vim alacritty tmux git dirs

.PHONY: profile
profile:
	ln -vsf .dotfiles/.profile ${HOME}/.profile

.PHONY: fish
fish: profile
	mkdir -p ${HOME}/.config/fish
	ln -vsf ../../.dotfiles/fish/config.fish ${HOME}/.config/fish/config.fish

.PHONY: bash
bash: profile
	ln -vsf .dotfiles/.bashrc ${HOME}/.bashrc

.PHONY: zsh
zsh: profile
	ln -vsf .dotfiles/.zshrc ${HOME}/.zshrc

.PHONY: vim
vim:
	ln -vsf .dotfiles/.vimrc ${HOME}/.vimrc
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall +qall

.PHONY: alacritty
alacritty:
	ln -vsf ../.dotfiles/alacritty ${HOME}/.config/alacritty

.PHONY: tmux
tmux:
	ln -vsf .dotfiles/.tmux.conf ${HOME}/.tmux.conf

.PHONY: git
git:
	git config --global user.name $(GIT_NAME)
	git config --global user.email $(GIT_MAIL)
	git config --global push.default current

.PHONY: dirs
dirs:
	@test -d ~/.bin || mkdir -v ~/.bin

.DEFAULT_GOAL := install

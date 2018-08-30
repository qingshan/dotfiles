install: brew shell dotfiles powerline vim

brew:
	@sh scripts/brew.sh

shell:
	@sh scripts/shell.sh

dotfiles:
	@ln -vsf .dotfiles/.profile ${HOME}/.profile
	@ln -vsf .dotfiles/.zshrc ${HOME}/.zshrc
	@ln -vsf .dotfiles/.vimrc ${HOME}/.vimrc
	@ln -vsf .dotfiles/.tmux.conf ${HOME}/.tmux.conf

powerline:
	@sh ./scripts/powerline.sh

vim:
	@sh scripts/vim.sh

macos:
	@sh scripts/macos.sh

.PHONY: install
.DEFAULT_GOAL := install

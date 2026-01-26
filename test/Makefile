DOCKER := $(shell if command -v container >/dev/null 2>&1; then echo "container"; else echo "docker"; fi)

.PHONY: test
test: server-test desktop-test

.PHONY: prepare
prepare:
	cd ~/.dotfiles/test
	ssh-keygen -t ed25519 -C test@dotfiles -N "" -f ./id_ed25519
	chmod 600 ./id_ed25519

server-test: prepare
	$(DOCKER) build -t dotfiles-server -f Dockerfile.server .
	$(DOCKER) run --name dotfiles-server -d --rm -p 8022:22 dotfiles-server
	sleep 1
	ssh -q -i id_ed25519 -p 8022 qingshan@127.0.0.1 -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null" "rustup show"
	$(DOCKER) stop dotfiles-server

.PHONY: desktop-test
desktop-test: prepare
	$(DOCKER) build -t dotfiles-desktop -f Dockerfile.desktop .
	$(DOCKER) run --name dotfiles-desktop -d --rm -p 8022:22 dotfiles-desktop
	sleep 1
	ssh -q -i id_ed25519 -p 8022 qingshan@127.0.0.1 -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null" "rustup show"
	$(DOCKER) stop dotfiles-desktop

.DEFAULT_GOAL := install

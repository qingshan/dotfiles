DOCKER := $(shell if command -v container >/dev/null 2>&1; then echo "container"; else echo "docker"; fi)

.PHONY: test
test: server-test desktop-test

server-test:
	cd ~/.dotfiles/test
	$(DOCKER) build --no-cache -t testbox -f Dockerfile.server .
	$(DOCKER) run --name testbox -d --rm -p 8022:22 testbox
	sleep 1
	chmod 600 id_rsa
	ssh -q -i id_rsa -p 8022 qingshan@127.0.0.1 -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null" "rustup show"
	$(DOCKER) stop testbox

.PHONY: desktop-test
desktop-test:
	cd ~/.dotfiles/test
	$(DOCKER) build -t testbox -f Dockerfile.desktop .
	$(DOCKER) run --name testbox -h testbox -d --rm -p 8022:22 testbox
	sleep 1
	chmod 600 id_rsa
	ssh -q -i id_rsa -p 8022 qingshan@127.0.0.1 -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null" "rustup show"
	$(DOCKER) stop testbox

.DEFAULT_GOAL := install

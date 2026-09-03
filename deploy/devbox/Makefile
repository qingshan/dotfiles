OS = ubuntu
SSH_PUBKEY := $(shell cat ~/.ssh/id_ed25519.pub)

.PHONY: install
install: $(OS)
	virt-install \
		--name devbox \
		--memory 8192 \
		--vcpus 8 \
		--os-variant ubuntu24.04 \
		--disk path=/var/lib/libvirt/images/devbox/devbox.qcow2,size=20,format=qcow2 \
		--network network=default \
		--console pty,target_type=serial \
		--noautoconsole \
		--graphics none \
		--import \
		--cloud-init user-data=user-data.yaml,meta-data=meta-data.yaml

.PHONY: ubuntu
ubuntu:
	mkdir -p /var/lib/libvirt/images/devbox
	cd /var/lib/libvirt/images/devbox
	wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
	qemu-img convert -p -f qcow2 -O qcow2 noble-server-cloudimg-amd64.img devbox.qcow2
	qemu-img resize devbox.qcow2 20G
	cat ~/.dotfiles/deploy/devbox/ubuntu-init.yaml | sed "s/__SSH_PUBKEY__/$(SSH_PUBKEY)/g" > user-data.yaml

.DEFAULT_GOAL := install

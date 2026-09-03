# Deploy on Linux

## Servers

bare-metal host servers could be any Linux of arch/debian/rocky.
- docker
- libvirt

### Install docker

Follow this doc: [Install Docker Engine](https://docs.docker.com/engine/install/)

### Install libvirt

```shell
sudo apt install qemu-kvm libvirt-daemon-system
```

### User

Create user with:
```shell
sudo useradd -m -s /bin/bash qingshan
sudo usermod -aG sudo qingshan
sudo usermod -aG adm qingshan
sudo usermod -aG docker qingshan
sudo usermod -aG libvirt qingshan
echo "qingshan ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/qingshan
```

## VMs

devbox: setup using cloud-init with libvirt.

### Docker Contexts

```shell
docker context create lab --docker "host=ssh://qingshan@lab"
docker context use lab
```

## Containers

devpod: setup with docker container for test.

# Linux

## Install docker

## Install libvirt

## User

```shell
sudo useradd -m -s /bin/bash qingshan
sudo usermod -aG sudo qingshan
sudo usermod -aG adm qingshan
sudo usermod -aG docker qingshan
sudo usermod -aG libvirt qingshan
echo "qingshan ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/qingshan
```

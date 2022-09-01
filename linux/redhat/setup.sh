#!/usr/bin/sh

sudo dnf update -y
sudo dnf install epel-release -y
sudo dnf install cmake gcc make curl clang -y
sudo dnf install git
sudo dnf install vim
sudo dnf install zsh
sudo dnf install ripgrep

sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce -y
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker $USER

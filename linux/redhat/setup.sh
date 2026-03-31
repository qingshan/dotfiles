#!/usr/bin/sh

echo "Install tools"
sudo dnf update -y
sudo dnf install -y epel-release
sudo dnf install -y make \
  curl \
  wget \
  fzf \
  git \
  vim \
  ripgrep \
  zoxide \
  tmux

sudo dnf install 'dnf-command(config-manager)'

# docker
echo "Install docker"
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce -y
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker $USER

# github
echo "Install gh"
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install -y gh

# fish
echo "Install fish"
FISH_VERSION=$(curl -s "https://api.github.com/repos/fish-shell/fish-shell/releases/latest" | grep -Po '"tag_name": "\K[0-9.]+')
curl -sL "https://github.com/fish-shell/fish-shell/releases/latest/download/fish-$FISH_VERSION-linux-x86_64.tar.xz" | sudo tar -xJ -C /usr/local/bin

# starship
echo "Install starship"
curl -sS https://starship.rs/install.sh | sh -s -- -y

# rustup
echo "Install rustup"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# just
echo "Install just"
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | sudo bash -s -- --to /usr/local/bin

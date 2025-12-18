#!/usr/bin/sh

sudo apt update
sudo apt upgrade -y
sudo apt install -y \
  software-properties-common \
  build-essential \
  fonts-jetbrains-mono \
  curl \
  wget \
  make \
  git \
  git-lfs \
  zsh \
  fish \
  fzf \
  unzip \
  ripgrep \
  fd-find \
  bat \
  direnv \
  zoxide \
  tldr \
  htop \
  rsync \
  tmux \
  vim \
  gh \
  alacritty \
  jq

# nerd font
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip \
  && cd ~/.local/share/fonts \
  && unzip JetBrainsMono.zip \
  && rm JetBrainsMono.zip
  && fc-cache -fv

# starship
curl -fsSL https://starship.rs/install.sh | sh

# regolith
curl -fsSL https://regolith-desktop.org/regolith.key | gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg > /dev/null
echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] https://regolith-desktop.org/release-3_2-debian-bookworm-amd64 bookworm main" | sudo tee /etc/apt/sources.list.d/regolith.list
sudo apt update
sudo apt install -y regolith-desktop regolith-session-flashback regolith-look-lascaille
sudo apt install -y lightdm regolith-lightdm-config
sudo apt install -y i3xrocks-battery i3xrocks-bluetooth i3xrocks-volume

# pinyin
sudo apt install -y fcitx5 fcitx5-pinyin

# brave browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser
xdg-settings set default-web-browser brave-browser.desktop

# alacritty as default terminal
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 70

# user shell
chsh -s $(which fish)

# grub
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
sudo update-grub

# network interfaces
cat <<EOF | sudo tee /etc/network/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback
EOF

# regorith
sudo sed -i '/greeter-hide-users/s/true/false/' /usr/share/lightdm/lightdm.conf.d/01_debian.conf
sudo sed -i '/^  mode /a\\  modifier none' /usr/share/regolith/i3/config.d/70_bar

# xremap
sudo gpasswd -a qingshan input
echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/input.rules
echo uinput | sudo tee /etc/modules-load.d/uinput.conf

# xremap & resume services
mkdir -p $HOME/.config/systemd/user && cp ~/.dotfiles/debian/*.service ${HOME}/.config/systemd/user
systemctl --user daemon-reload
systemctl --user enable xremap
systemctl --user enable resume@qingshan.service

# regolith
ln -vsf ../.dotfiles/debian/regolith3 ${HOME}/.config/regolith3

#!/usr/bin/sh

# Remove unused pacman packages
sudo pacman -Rns palemoon-bin epdfview

# Install pacman packages
sudo pacman --noconfirm --needed -S - < pacmanlist.txt

# Install AUR helper
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg --noconfirm -si
cd ..
rm -rf paru
paru --noconfirm --needed -S - < aurlist.txt

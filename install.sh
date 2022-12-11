#!/bin/bash

# install package
# pacman -S <package name>
# uninstall package
# pacman -Rsc <package name>
# search package by name
# pacman -Ss <package name>
# update package list
#pacman -Syy
# upgrade everything
# pacman -Syu


clear

username=$(id -u -n 1000)
builddir=$(pwd)

echo "PostInstall starts now"
# install video drivers
# amd gpu
# pacman -Syu --noconfirm xf86-video-amdgpu
# intel gpu
# pacman -Syu --noconfirm xf86-video-intel
# nvidia gpu
# pacman -Syu --noconfirm nvidia nvidia-tools
# vm gpu
sudo pacman -Syu --noconfirm xf86-video-qxl
sudo pacman -S --noconfirm --needed base-devel
sudo pacman -S --noconfirm --needed xorg-server xorg-xinit git alacritty feh picom firefox dmenu lxsession arandr unzip wget pulseaudio pavucontrol flameshot neovim lxappearance sddm polybar neofetch conky xorg-apps


echo "installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install yay -- AUR package mananger
echo "installing yay"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

echo "installing leftwm"
yay --noconfirm -S leftwm

echo "creating config folders"
mkdir ~/.config/leftwm

echo "copying default config files"
cp ./config/leftwm/themes/basic_polybar/ ~/.config/leftwm/
ln -s ~/.config/leftwm/themes/basic_polybar current

echo "installing fonts"
# Installing fonts
cd "$builddir" || exit
sudo yay -S fonts-font-awesome -y
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d "/home/$username/.fonts"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d "/home/$username/.fonts"
mv dotfonts/fontawesome/otfs/*.otf "/home/$username/.fonts/"
chown "$username:$username" "/home/$username/.fonts/*"

# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip

echo "installing cursor"
# Install Nordzy cursor
git clone https://github.com/alvatip/Nordzy-cursors
cd Nordzy-cursors || exit
./install.sh
cd "$builddir" || exit
rm -rf Nordzy-cursors

# Enable graphical login and change target from CLI to GUI
tar -xzvf slice.tar.gz --strip 1 --one-top-level=/usr/share/sddm/themes/slice
sudo cp -f "$builddir/sddm.conf" /etc/
sudo systemctl enable sddm
sudo systemctl set-default graphical.target






echo "PostInstall finishied reboot now....."

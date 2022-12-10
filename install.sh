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

echo "PostInstall starts now"
# install video drivers
# amd gpu
# pacman -Syu --noconfirm xf86-video-amdgpu
# intel gpu
# pacman -Syu --noconfirm xf86-video-intel
# nvidia gpu
# pacman -Syu --noconfirm nvidia nvidia-tools
# vm gpu
pacman -Syu --noconfirm xf86-video-qxl
pacman -S --noconfirm xorg xorg-xinit git alacritty bspwm sxhkd nitrogen picom firefox dmenu lxsession arandr

echo "creating config folders"
mkdir ~/.config/bspwm
mkdir ~/.config/sxhkd

echo "copying default config files"
cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
cp /usr/share/doc/sxhkdrc/examples/bspwmrc ~/.config/sxhkd/

cp /etc/X11/xinit/xinitrc ~/.xinitrc





echo "PostInstall starts now"

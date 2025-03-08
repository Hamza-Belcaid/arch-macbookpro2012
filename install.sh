#!/bin/bash

# This is for changing colors in the terminal
textreset="\033[0m"
orange="\033[93m"
green="\033[0;92m"

echo "Downloading packages."
pacman -S --noconfirm broadcom-wl
echo -e "${green}[Done]${textreset}"

echo "Installing gpu-switch."
cd /tmp && git clone https://aur.archlinux.org/gpu-switch.git
cd gpu-switch
makepkg -si
echo -e "${green}[Done]${textreset}"

echo "Installing mbpfan."
cd /tmp && git clone https://aur.archlinux.org/mbpfan-git.git
cd mbpfan-git
makepkg -si

sed -i 's/#min_fan1_speed = 2000/min_fan1_speed = 2160/' /etc/mbpfan.conf
sed -i 's/#max_fan1_speed = 6200/max_fan1_speed = 5940/' /etc/mbpfan.conf
sed -i 's/low_temp = 63/low_temp = 48/' /etc/mbpfan.conf 
sed -i 's/high_temp = 66/high_temp = 58/' /etc/mbpfan.conf

echo -e "Enabling the service."
systemctl start mbpfan.service
systemctl enable mbpfan.service

echo -e "${green}[Done]${textreset}"



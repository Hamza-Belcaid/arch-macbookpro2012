#!/bin/bash

# This section is responsible for changing colors in the terminal
textreset=$(tput sgr0)
orange=$(tput setaf 202)
green=$(tput setaf 118)

# These are warning messages before installation
echo -e "${orange}[Warning]${textreset} This script should be run after arch-chroot into the arch installation.\n"

echo -e "${green}[Important]${textreset} Make sure to change values for things such as the region and keyboad layout, by default they are configured for my specific needs." 

#This is where the installation script starts
ln -sf /usr/share/zoneinfo/Africa/Casablanca /etc/localtime
hwclock --systohc

echo -e "Configuring systeme language to English-US"
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
locale-gen
echo -e "${green}[Done]"

echo -e "Configuring Keyboard layout to german"
echo "KEYMAP=de" >> /etc/vconsole.conf
echo -e "${green}[Done]"

echo -e "Configuring hostname to macbookpro"
echo "macbookpro" >> /etc/hostname
echo -e "${green}[Done]"

echo -e "Creating mac user"
useradd -aG wheel -m mac
echo -e "${green}[Done]"

echo -e "Enter the user password"
passwd mac
echo -e "${green}[Done]"


#!/bin/bash

# This section is responsible for changing colors in the terminal
textreset="\033[0m"
orange="\033[93m"
green="\033[0;92m"

# These are warning messages before installation
echo -e "${orange}[Warning]${textreset} This script should be run after arch-chroot into the arch installation.\n"

echo -e "${green}[Important]${textreset} Make sure to change values for things such as the region and keyboad layout, by default they are configured for my specific needs.\n" 

#This is where the installation script starts
ln -sf /usr/share/zoneinfo/Africa/Casablanca /etc/localtime
hwclock --systohc

echo -e "Configuring system language to English-US"
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
locale-gen
echo -e "${green}[Done]${textreset}" 

echo -e "Configuring Keyboard layout to german"
echo "KEYMAP=de" >> /etc/vconsole.conf
echo -e "${green}[Done]${textreset}"

echo -e "Configuring hostname to macbookpro"
echo "macbookpro" >> /etc/hostname
echo -e "${green}[Done]${textreset}"

echo -e "Creating mac user"
useradd -G wheel -m mac
echo -e "${green}[Done]${textreset}"

echo -e "Enter the user password"
passwd mac
echo -e "${green}[Done]${textreset}"

echo -e "Downloading bootloader package"
pacman -S efibootmgr
echo -e "${green}[Done]${textreset}"

echo -e "installing the bootloader"
bootctl --path=/boot install
echo "default Arch-Linux" >> /boot/loader/loader.conf
echo "title Arch Linux" >> /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
echo "options root=/dev/sda3 rw" >> /boot/loader/entries/arch.conf
echo -e "${green}[Done]${textreset}"






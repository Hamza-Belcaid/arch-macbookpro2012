#!/bin/bash

# This is for changing colors in the terminal
textreset="\033[0m"
orange="\033[93m"
green="\033[0;92m"

# These are warning messages before installation
echo -e "${orange}[Warning]${textreset} This script should be run in the arch-chroot environment on a minimal Arch install.\n"

echo -e "${green}[Important]${textreset} Make sure to change values for things such as the region and keyboad layout.\nDefault Timezone = Casablanca\nDefault Language = English-US\n" 
sleep 5 

# Configuring locales
echo "Configuring timezone to Casablanca GMT+01:00."
ln -sf /usr/share/zoneinfo/Africa/Casablanca /etc/localtime
hwclock --systohc
echo -e "${green}[Done]${textreset}" 

echo "Configuring system language to English-US."
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo -e "${green}[Done]${textreset}" 

echo "Configuring Keyboard layout to german(austria)."
echo "KEYMAP=de_CH-latin1" >> /etc/vconsole.conf
echo -e "${green}[Done]${textreset}"

echo "Configuring hostname to 'macbookpro'."
echo "macbookpro" >> /etc/hostname
echo -e "${green}[Done]${textreset}"

echo "Creating user mac"
useradd -G wheel -m mac
echo -e "${green}[Done]${textreset}"

echo "Enter the user password for mac"
passwd mac
echo -e "${green}[Done]${textreset}"

echo "Configuring hosts file." 
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 macbookpro" >> /etc/hosts
echo -e "${green}[Done]${textreset}"

echo "Configuring pacman."
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 4/' /etc/pacman.conf
sed -i '38i\ILoveCandy' /etc/pacman.conf
sed -i '77s/^#//' /etc/pacman.conf
sed -i '78s/^#//' /etc/pacman.conf
echo -e "${green}[Done]${textreset}"

echo "Installing Reflector."
pacman -S --noconfirm reflector
sed -i '/--country/c\--country colors= Morocco,Spain,France,Italy,Germany' /etc/xdg/reflector/reflector.conf
echo -e "${green}[Done]${textreset}"

echo "Installing sudo."
pacman -S --noconfirm sudo 
echo "mac ALL=(ALL) ALL" >> /etc/sudoers.d/mac
echo -e "${green}[Done]${textreset}"

echo "Installing the bootloader."
pacman -S --noconfirm efibootmgr
bootctl --path=/boot install
echo "default Arch-Linux" >> /boot/loader/loader.conf
echo "title Arch Linux" >> /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf
# Finding what is the root partition
root=$(df -h | grep "/$" | cut -d " " -f 1)
echo "options root=$root rw" >> /boot/loader/entries/arch.conf
echo -e "${green}[Done]${textreset}"

echo "Downloading packages."
pacman -S --noconfirm neovim networkmanager network-manager-applet intel-ucode mtools dosfstools ntfs-3g xdg-user-dirs base-devel linux-headers pacman-contrib go wl-clipboard gvfs inetutils dnsmasq ufw broadcom-wl-dkms bluez bluez-utils cups hplip bash-completion flatpak acpi acpid acpi_call tlp btop firefox timeshift 
echo -e "${green}[Done]${textreset}"

echo "Installing yay."
su mac -c "cd /tmp && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -s"
pacman -U --noconfirm /tmp/yay/yay*.pkg.tar.zst
echo -e "${green}[Done]${textreset}"

echo "Installing gpu-switch."
su mac -c "cd /tmp && git clone https://aur.archlinux.org/gpu-switch.git && cd gpu-switch && makepkg -s"
pacman -U --noconfirm /tmp/gpu-switch/gpu-switch*.pkg.tar.zst
echo -e "${green}[Done]${textreset}"

echo "Installing mbpfan."
su mac -c "cd /tmp && git clone https://aur.archlinux.org/mbpfan-git.git && cd mbpfan-git && makepkg -s"
pacman -U --noconfirm /tmp/mbpfan-git/mbpfan-git*.pkg.tar.zst
sed -i 's/#min_fan1_speed = 2000/min_fan1_speed = 2160/' /etc/mbpfan.conf
sed -i 's/#max_fan1_speed = 6200/max_fan1_speed = 5940/' /etc/mbpfan.conf
sed -i 's/low_temp = 63/low_temp = 48/' /etc/mbpfan.conf 
sed -i 's/high_temp = 66/high_temp = 58/' /etc/mbpfan.conf
echo -e "${green}[Done]${textreset}"

echo -e "Enabling services."
systemctl enable NetworkManager 
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable tlp
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable acpid
systemctl enable mbpfan.service
systemctl enable reflector.service
systemctl enable cronie.service
echo -e "${green}[Done]${textreset}"

echo -e "${orange}Enabling ufw and setting the default firewall policy to deny.${textreset}"
ufw default deny
ufw enable
echo -e "${green}[Done]${textreset}"

#This loops keeps repeating until the user enters a valid number
error=1
while [ $error == 1 ]; do
  echo -e "Choose which desktop environment to install ? (ex:1/2/3): 
  1-KDE Plasma | ~550 MB download size"
  read s1

  case $s1 in
  
    1)
      echo "Installing KDE plasma desktop environment."
      error=0
      ./DE/kde-plasma.sh;;
    *)
      echo "Invalid Choice, Make sure to enter a number like 1 for KDE plasma.\n"
  esac

done

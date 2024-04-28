#!bin/bash

#NOTE: This script is run after the user chooses to install KDE Plasma Desktop environment, It is possible to run it manualy if desired

sudo pacman -S --noconfirm plasma sddm konsole

systemctl enable sddm
echo "Installation finished! you can reboot now."


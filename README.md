# Arch installation script for MacBook Pro 2012 (Still a work in progress)

This is an Arch Linux installation script specifically for a [MacBook Pro (Retina, 15-inch, Mid 2012).](https://support.apple.com/en-us/112576 "MacBook Pro (Retina, 15-inch, Mid 2012)")
The purpose of this script is to create an automated Arch install for this specific laptop with my personal setup/configs, you can also use it without any of my personal configs.

# Features
* Basic system configuration
* Installs packages (ex: neovim,networkmanager,etc) 
* Various Desktop Environments to choose from. (only KDE Plasma as of now)


# Usage

NOTE: This script should be run in the chroot environment on a basic Arch installation.
```
$ git clone https://github.com/Hamza-Belcaid/arch-macbookpro2012.git
$ cd arch-macbookpro2012
$ chmod +x install.sh 
$ ./install.sh 
```

# Linux installation guide for Macbook Pro 2012 (work in progress)

This is a guide for installing Linux on a [MacBook Pro (Retina, 15-inch, Mid 2012).](https://support.apple.com/en-us/112576 "MacBook Pro (Retina, 15-inch, Mid 2012)")
It contains recommendations and driver installation for a good linux experience on this Macbook model.

# Features

- Recommended Distros and Desktop Environements.
- Nvidia Driver setup (To-Do)
- Fan Control
- Wifi Driver
- GPU Switching

### Table of Contents
- [Automated Arch linux script](#Automated-Arch-linux-script)
- [Recommended Distributions](#Recommended-Distributions)
- [Problems](#Problems)
- [Nvidia Drivers](#Nvidia-Drivers)
- [Fan Control](#Fan-Control)
- [Wifi Drivers](#Wifi-Drivers)
- [GPU Switching](#GPU-Switching)

# Distributions

## Arch Linux :

    ✅ A good base for building and customising your OS to your choice.
    
    ❌ Requires mannualy Installing and configuring everything.
    
Note : You can use the install.sh script to automatically install all the necessary drivers.
Head on to the "Automated Arch linux script" section.

## CachyOS : (My Personal Recommendation)

    ✅ Beginner friendly Arch Distro.

    ✅ Fast and simple GUI Installer.

    ✅ Installs the correct Nvidia Drivers.
    
# Automated Arch linux script

This script can be used on Arch Linux to automatically install Nvidia drivers, Wifi Drivers and Fan Control.

```
git clone https://github.com/Hamza-Belcaid/arch-macbookpro2012.git
cd arch-macbookpro2012
chmod +x install.sh 
./install.sh 
```    

Note : You can follow the rest of the guide if you would like to manually set up everything or if you're using a different Distribution.

# Nvidia Drivers

This macbook comes with an Nvidia GT 650M with 1GB of GDDR5, its part of the Kepler series which was discontinued. 

**Supported Drivers :**

- Nvidia 470.xx Legacy Drivers
- Nouveau
- NVK (NVK does not support this gpu currently but it should be supported in the futur)

## Installation :

(To-do)

# Fan Control

Fan control is provided by [mbpfan](https://github.com/linux-on-mac/mbpfan), it might be setup by some distros out of the box, if not you can install it manually.

## Installation :

### Arch :
```
yay -S mbpfan-git

```
Or if you're using paru (ex: CachyOS):
```
paru -S mbpfan-git
```
## Configuration :

**Editing the fan speed :**

```
vim /etc/mbpfan.conf
```

**Modify the config file with the following :**

```
min_fan1_speed = 2160
max_fan1_speed = 5940
low_temp = 48  // This can be customized to your liking
high_temp = 58 // This can be customized to your liking
```

**Enabling and starting the service at startup :**

```
systemctl start mbpfan.service
systemctl enable mbpfan.service
```

# Wifi Drivers

This macbook comes with the broadcom BCM wireless card.

**Supported Drivers :**

- broadcom-wl (Recommended)
- broadmon-wl-dkms
- b43-firmware

Note : This is the name of the packages on Arch linux, they might be slighty different on other distributions, go to the Installation section below and look for your distrobution.

## Installation :

### Arch :

```
pacman -S broadcom-wl
```

Or  for the opensource driver :

```
yay -S b43-firmware
```
### Debian/Ubuntu :

(To-do)

# Gpu Switching
This macbook has an Intel HD Graphics 4000 integrated GPU and an Nvidia GT 650M dedicated gpu.

GPU switching is provided by this [repo](https://github.com/0xbb/gpu-switch), switching gpus requires restarting the macbook.

**Clone the repository**

```
git clone https://github.com/0xbb/gpu-switch.git
cd gpu-switch
```
Note : gpu-switch is also available on the AUR.

**Switch to the integrated GPU :**

```
sudo ./gpu-switch -i
```

**Switch to the dedicated GPU :**

```
sudo ./gpu-switch -d
```

# Problems

- HDMI ouptut might not work while using the proprietary Nvidia driver, the only workaround is to use the Nouveau driver or wait until NVK has support for the GT 650M.
(Or possibly use a usb-to-hdmi adapter)

- Unstable wifi connection while using the b43-firmware, it seems to work better when the macbook is farther from the router, also it has slightly better connection range than other drivers.

- Small dpi or screen scaling can be fixed by changing the display scale of your Desktop environement, Display scaling works better on wayland while using the nouveau driver, on xorg it should work fine with any driver after changing scaling and restarting.


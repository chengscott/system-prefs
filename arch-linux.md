# Arch Linux

## Download

[NCTU mirror](http://archlinux.cs.nctu.edu.tw/iso/)

## Disk

- `lsblk` for listing block devices
- `fdisk /dev/sdb` for partitioning hard drive
    - `g` for GPT partition
    - `n` new partition
    - `t` change partition type
    - `w` write and exit
- build file systems
    - `mkfs.fat /dev/sdb1`
    - `mkswap /dev/sdb2`
    - `mkfs.ext4 /dev/sdb3`

## Mount

- `mount /dev/sdb3 /mnt`
- `mount /dev/sdb1 /mnt/boot`
    - may need `mkdir /mnt/boot`

## Install

- `pacstrap /mnt base base-devel`
- `genfstab -U /mnt >> /mnt/etc/fstab`

## Settings

- `arch-chroot /mnt`
- `echo hostname > /etc/hostname`
- `ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime`
    - may `mv` exists file to backup
- `vim /etc/locale.gen`
    - uncomment the `en_US.UTF-8 UTF-8`
- `vim /etc/locale.conf`
    - create and paste `LANG="en_US.UTF-8"`
- `locale-gen`
- `passwd # for root password`

## Boot

- `mkinitcpio -p linux`
- `pacman -S grub efibootmgr`
- `grub-install --target=x86_64-efi --efi-directory=/dev/sdb1 --bootloader-id=grub`
- `grub-mkconfig -o /boot/grub/grub.cfg`

## User

- `useradd -m -G wheel chengscott`
- `passwd chengscott`
- `visudo`

## GUI & XServer

- xf86-video-intel
- nvidia
- bumblebee
- xorg-server
- xorg-xinit
    - `cp /etc/X11/xinit/xinitrc ~/.xinitrc`
    - setup desktop environment

## Network

- broadcom-wl-dkms
    - `rmmod b34 b43legacy ssb bcm43xx brcm80211 brcmfmac brcmsmac bcma wl`
    - `modprobe wl`
    - linux-headers
- networkmanager
- network-manager-applet
- `systemctl start NetworkManager`
- `systemctl enable NetworkManager`
- gnome-keyring

## AUR

## Utils

- `systemctl start dhcpd`
- IME
    - fcitx
    - fcitx-im
- fonts
    - noto-fonts-cjk
- Desktop
    - budgie-desktop
- tools
    - chromium
    - vlc
    - aria2
    - gnome-tweak-tool
- dev tools
    - atom
    - openssh
    - gnome-terminal


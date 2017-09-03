# Arch Linux

## Download Mirror

- [NCTU mirror](http://archlinux.cs.nctu.edu.tw/iso/)

## Partition

- `lsblk` for listing block devices
- [UEFI/GPT example layout](https://wiki.archlinux.org/index.php/Partitioning#UEFI.2FGPT_example_layout)
- `fdisk /dev/sdb` for partitioning hard drive
    - `g` for GPT partition
    - `n` new partition
    - `t` change partition type
    - `w` write and exit
- format partitions
    - `mkfs.fat /dev/sdb1`
    - `mkswap /dev/sdb2`
    - `mkfs.ext4 /dev/sdb3`

## Mount

- `mount /dev/sdb3 /mnt`
- `mkdir /mnt/boot`
- `mount /dev/sdb1 /mnt/boot`

## Base System

- `pacstrap /mnt base base-devel`
- `genfstab -U /mnt >> /mnt/etc/fstab`

## Settings

- `arch-chroot /mnt`
- `echo hostname > /etc/hostname`
- `ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime`
- `echo 'LANG=en_US.UTF-8' > /etc/locale.conf`
- `echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen`
- `locale-gen`
- `passwd` for root password

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
- `systemctl start dhcpd # after reboot`
- networkmanager
    - `systemctl start NetworkManager`
    - `systemctl enable NetworkManager`
- network-manager-applet
- gnome-keyring

## Input Method Framework

- noto-fonts-cjk
- [fcitx Usage](https://wiki.archlinux.org/index.php/fcitx#Non_desktop_environment)
- fcitx-im
- fcitx-chewing

## Desktop Environment

- gnome-shell
- gnome-tweak-tool
- [paper icon theme - AUR](https://aur.archlinux.org/packages/paper-icon-theme-git/)
- [paper gtk theme - AUR](https://aur.archlinux.org/packages/paper-gtk-theme-git/)
- gnome-{screenshot,terminal}
- vlc
- chromium

## Utils

- aria2
- atom
- git
- openconnect
- openssh
    - `chmod 600 ~/.ssh/config`
```bash=
Host demo
HostName 10.0.0.1
User chengscott
Port 22
IdentityFile ~/.ssh/demo.pem
```
- rsync
- traceroute
- tree
- tmux
    - `echo 'set -g mouse on' >> ~/.tmux.conf`
    - [tmux cheatsheet](https://gist.github.com/MohamedAlaa/2961058)
- vim


# Arch Linux

## Download Mirror

- [NCTU mirror](http://archlinux.cs.nctu.edu.tw/iso/)
- `dd bs=4M if=/path/to/archlinux.iso of=/dev/sdx status=progress oflag=sync`

## Partition

- `lsblk -f` list block devices with filesystems
- `fdisk -l` list partition tables
- [UEFI/GPT example layout](https://wiki.archlinux.org/index.php/Partitioning#UEFI.2FGPT_example_layout)
- `fdisk /dev/sdb` manipulate disk partition table
    - `g` creates a new empty GPT partition table
    - `n` add a new partition
    - `t` change a partition type
    - `w` write table to disk and exit
- format partitions
    - `mkfs.fat /dev/sdb1`
    - `mkswap /dev/sdb2`
    - `mkfs.ext4 /dev/sdb3`
- mount
    - `mount /dev/sdb3 /mnt`
    - `mkdir /mnt/boot`
    - `mount /dev/sdb1 /mnt/boot`

## Base System

- `pacstrap /mnt base base-devel`
- `genfstab -U /mnt >> /mnt/etc/fstab`

## Boot loader

- `arch-chroot /mnt`
- `mkinitcpio -p linux`
- `pacman -S grub efibootmgr`
- for dual boot, install and run `os-prober`
- `grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub`
- `grub-mkconfig -o /boot/grub/grub.cfg`


## Configs

- `echo hostname > /etc/hostname`
- `passwd` set the root password
- Time zone
    - `timedatectl set-ntp true`
    - `hwclock --systohc`
    - `ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime`
- Locale
    - `echo 'LANG=en_US.UTF-8' > /etc/locale.conf`
    - `echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen`
    - `locale-gen`
- User
    - `useradd -m -G wheel chengscott`
    - `passwd chengscott`
    - `visudo`

## Network

- [Broadcom wireless](https://wiki.archlinux.org/index.php/broadcom_wireless#Installation)
    - `pacman -S broadcom-wl-dkms linux-headers`
    - `rmmod b43 ssb`
    - `depmod -a`
    - `modprobe wl`
- `systemctl start dhcpcd # after reboot`
- `pacman -S openssh openvpn openconnect sshfs`
- `pacman -S networkmanager networkmanager-{openvpn,openconnect,pptp} network-manager-applet gnome-keyring`
    - `systemctl start NetworkManager`
    - `systemctl enable NetworkManager`

## Xorg & Desktop Environment

- `pacman -S xf86-video-intel nvidia bumblebee xorg-server xorg-xinit`
- gnome-shell
    - `cp /etc/X11/xinit/xinitrc ~/.xinitrc`
    - modify `~/.xinitrc` and append `exec gnome-session`
- `yay -S paper-icon-theme-git paper-gtk-theme-git chrome-gnome-shell-git`
- `pacman -S gnome-{tweak,screenshot,terminal,calculator} nautilus evince eog vlc chromium`

## Input Method Framework

- noto-fonts-cjk
- [fcitx Usage](https://wiki.archlinux.org/index.php/fcitx#Usage)
- `pacman -S fcitx-{im,chewing,configtool}`
```bash=
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
```

## Utils

- `pacman -S fish tmux git wget aria2 rsync time tree htop lsof cpupower darkhttpd`
- `pacman -S jdk8-openjdk icedtea-web`
- `pacman -S gdb clang python-pip cuda cudnn`
- `yay -S visual-studio-code-bin`
- [yay - AUR](https://aur.archlinux.org/packages/yay/)
    - `git clone https://aur.archlinux.org/yay.git `
    - `makepkg -si`
- `pacman -S sane cups cups-pdf gtk3-print-backends epson-inkjet-printer-201310w`
    - `systemctl start org.cups.cupsd.service`
    - `systemctl enable org.cups.cupsd.service`
    - `localhost:631`

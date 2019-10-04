# Arch Linux

## Download

- [NCTU mirror](http://archlinux.cs.nctu.edu.tw/iso/)
- `dd bs=4M status=progress oflag=sync if=/path/to/archlinux.iso of=/dev/sdx`

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

- (select mirrors in `/etc/pacman.d/mirrorlist`)
- `pacstrap /mnt base base-devel grub efibootmgr intel-ucode`
  - for dual boot, install `os-prober`
- `genfstab -U /mnt >> /mnt/etc/fstab`

## Boot loader

- `arch-chroot /mnt`
- `grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub`
- `grub-mkconfig -o /boot/grub/grub.cfg`

## Configs

- `echo hostname > /etc/hostname`
- `passwd` set the root password
- Time
    - `ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime`
    - `systemctl enable systemd-timesyncd`
    - `hwclock --systohc`
- Locale
    - `echo 'LANG=en_US.UTF-8' > /etc/locale.conf`
    - `echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen`
    - `locale-gen`
- User
    - `useradd -m -G wheel chengscott`
    - `passwd chengscott`
    - `VISUAL=vim visudo`

## Network

- `systemctl start dhcpcd # after reboot`
- `pacman -S openssh openvpn openconnect sshfs`
- `pacman -S networkmanager networkmanager-{openvpn,openconnect} network-manager-applet gnome-keyring`
    - `systemctl enable --now NetworkManager`

## Graphical User Interface

- `pacman -S xorg-server xorg-xinit xf86-video-intel nvidia bumblebee`
- gnome-shell
    - `cp /etc/X11/xinit/xinitrc ~/.xinitrc`
    - modify `~/.xinitrc`
```bash=
export XDG_SESSION_TYPE=x11
exec gnome-session
```
- `yay -S paper-icon-theme-git paper-gtk-theme-git chrome-gnome-shell-git`
- `pacman -S gnome-{tweaks,screenshot,terminal,calculator} nautilus evince eog vlc chromium`

## Input Method Framework

- `pacman -S noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-liberation`
- [fcitx Usage](https://wiki.archlinux.org/index.php/fcitx#Usage)
- `pacman -S fcitx-{im,chewing,configtool}`
```bash=
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
```

## Utils

- `pacman -S fish tmux code git wget aria2 rsync time tree htop`
- `pacman -S cuda cudnn gdb clang python-pip jupyter-notebook`
- `pacman -S darkhttpd cpupower lsof nmap`
- [yay - AUR](https://aur.archlinux.org/packages/yay/)
    - `git clone https://aur.archlinux.org/yay.git `
    - `makepkg -si`
- `pacman -S sane cups cups-pdf gtk3-print-backends epson-inkjet-printer-201310w`
    - `systemctl start org.cups.cupsd.service`
    - `localhost:631`

## Misc

- [ASUS X550JX](https://www.asus.com/Laptops/X550JX/specifications/) specs
- [ASUS N550JX](https://wiki.archlinux.org/index.php/ASUS_N550JX) ref
    - `nouveau` toubleshooting
- [Broadcom wireless](https://wiki.archlinux.org/index.php/broadcom_wireless#Installation)
    - `pacman -S broadcom-wl-dkms linux-headers`
    - `rmmod b43 ssb`
    - `depmod -a`
    - `modprobe wl`

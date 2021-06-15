# Arch Linux

## Download

- [NCTU mirror](http://archlinux.cs.nctu.edu.tw/iso/)
- `dd bs=4M status=progress oflag=sync if=/path/to/archlinux.iso of=/dev/sdz`

## Partition

- `lsblk -f` list block devices with filesystems
- `fdisk -l` list partition tables
- [UEFI/GPT example layout](https://wiki.archlinux.org/index.php/Partitioning#UEFI.2FGPT_example_layout)
- `fdisk /dev/sdx` manipulate disk partition table
    - `g` creates a new empty GPT partition table
    - `n` add a new partition
    - `t` change a partition type
    - `w` write table to disk and exit
- format partitions
    - `mkfs.fat /dev/sdx1`
    - `mkswap /dev/sdx2`
    - `mkfs.ext4 /dev/sdx3`
- mount
    - `mount /dev/sdx3 /mnt`
    - (UEFI) `mkdir /mnt/boot`
    - (UEFI) `mount /dev/sdb1 /mnt/boot`

## Base System

- (select mirrors in `/etc/pacman.d/mirrorlist`)
- `pacstrap /mnt linux base base-devel grub vim`
  - optional: `efibootmgr intel-ucode amd-ucode`
  - for dual boot, install `os-prober`
- `genfstab -U /mnt >> /mnt/etc/fstab`

## Boot loader

- `arch-chroot /mnt`
- (UEFI) `grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub`
- (BIOS) `grub-install /dev/sdx`
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

- (`systemctl start dhcpcd`)
- `pacman -S openssh openvpn openconnect sshfs`
- `pacman -S networkmanager networkmanager-{openvpn,openconnect} network-manager-applet gnome-keyring`
    - `systemctl enable --now NetworkManager`

## Graphical User Interface

- `pacman -S xorg-server xorg-xinit xf86-video-intel nvidia bumblebee`
- `gnome-shell`
    - `cp /etc/X11/xinit/xinitrc ~/.xinitrc`
    - modify `~/.xinitrc`
```bash=
export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11
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

- `pacman -S fish tmux git wget aria2 rsync time tree htop lsof`
- `pacman -S cuda cudnn gdb clang python-pip darkhttpd`
- `yay -S visual-studio-code-bin`
- [yay - AUR](https://aur.archlinux.org/packages/yay/)
    - `git clone https://aur.archlinux.org/yay.git `
    - `makepkg -si`
- (Printer) `pacman -S cups cups-pdf gtk3-print-backends`
    - `systemctl start org.cups.cupsd.service`
    - `localhost:631`
- (Network Printer) `pacman -S nss-mdns`
    - `systemctl start avahi-daemon`
    - modify `/etc/nsswitch.conf`
```
hosts: ... mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] dns ...
```

## Misc

- [ASUS X550JX](https://www.asus.com/Laptops/X550JX/specifications/) specs
- [ASUS N550JX](https://wiki.archlinux.org/index.php/ASUS_N550JX) ref
    - `nouveau` toubleshooting
- [Broadcom wireless](https://wiki.archlinux.org/index.php/broadcom_wireless#Installation)
    - `pacman -S broadcom-wl-dkms linux-headers`
    - `rmmod b43 ssb`
    - `depmod -a`
    - `modprobe wl`

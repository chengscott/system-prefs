# Windows

## Misc

- [UTC in Microsoft Windows](https://wiki.archlinux.org/title/System_time#UTC_in_Microsoft_Windows)
- create a bootable USB on MacOS:
    - find usb: `diskutil list`
    - `diskutil eraseDisk MS-DOS "WIN10" MBR /dev/diskX`
    - `hdiutil mount ./Win10_Eng_x64.iso`
    - `rsync -ahPv --exclude=sources/install.wim /Volumes/CPBA_X64FRE_EN-US_DV9/* /Volumes/WIN10`
    - `brew install wimlib`
    - `wimlib-imagex split /Volumes/CPBA_X64FRE_EN-US_DV9/sources/install.wim /Volumes/WIN10/sources/install.swm 3800`

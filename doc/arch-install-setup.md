# Arch Linux installation and setup

This document provides additional information for the installation and setup of Arch Linux according to the [Arch Wiki installation guide](https://wiki.archlinux.org/title/Installation_guide).
It assumes an installation to the NVMe drive /dev/nvme0n1 with an UEFI system and an encrypted root partition for a user _julian_ with a German keyboard layout.
The corresponding section of the installation guide which is replaced is given in parenthesis.

## Installation

Start by following sections 1.1 to 1.8 of the Arch Wiki installation guide. Afterwards, follow the next sections of this document.

### Partition the disks (1.9)

Securely erase the NVMe drive as described in the [Arch Wiki article](https://wiki.archlinux.org/title/Solid_state_drive/Memory_cell_clearing#NVMe_drive).

Start `parted` and create a new GUID Partition Table.

```
parted /dev/nvme0n1
(parted) mklabel gpt
```

Afterwards, create the EFI and root partitions.

```
(parted) mkpart efi fat32 0% 512MiB
(parted) set 1 esp on
(parted) mkpart root btrfs 512MiB 100%
```

#### Encrypt the root partition

Encrypt the root partition with dm-crypt and unlock it.

```
cryptsetup luksFormat /dev/nvme0n1p2
cryptsetup open /dev/nvme0n1p2 root
```

### Format the partitions (1.10)

Format the EFI partitions to FAT32 and the root partition to btrfs.

```
mkfs.fat -F 32 /dev/nvme0n1p1
mkfs.btrfs /dev/mapper/root
```

### Mount the partitions (1.11)

Mount the partitions to `/mnt/efi` and `/mnt` respectively.

```
mount /dev/mapper/root /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/efi
```

### Essential packages (2.2)

Select the microcode package according to your CPU manufacturer (AMD or Intel).

```
pacstrap /mnt base linux linux-firmware btrfs-progs networkmanager vi {amd|intel}-ucode
```

From now on, follow section 3.1 to 3.5 of the Arch Wiki installation guide.

### Initramfs (3.6)

Change the `HOOKS=(...)` line in `/etc/mkinitcpio.conf` to

```
HOOKS=(base udev autodetect keyboard keymap modconf block encrypt filesystems)
```

Enable lz4 compression by uncommenting `COMPRESSION=lz4` and setting `COMPRESSION_OPTIONS=(-9)`.

Regenerate the initramfs.

```
mkinitcpio -P
```

### Root password (3.7)

Set the root password to something simple (the root login will be disabled during setup).

```
passwd
```

### Boot loader (3.8)

Install `sbctl` and `efibootmgr`.

```
pacman -S efibootmgr sbctl
```

Add the file `/etc/kernel/cmdline` with the following line and `device-uuid` set to the UUID of /dev/nvme0n1p2.

```
cryptdevice=UUID=device-uuid:root root=/dev/mapper/root rw quiet bgrt_disable
```

Create the unified kernel image using `sbctl`. Note that we have to set `ESP_PATH` manually since `lsblk` will not work correctly within the chroot.

```
mkdir -p /efi/EFI/Linux
ESP_PATH=/efi sbctl bundle --save \
    {-a /boot/amd-ucode.img | -i /boot/intel-ucode.img} \
    -l /usr/share/systemd/bootctl/splash-arch.bmp \
    /efi/EFI/Linux/archlinux.efi
```

Add an EFI entry for the created image.

```
efibootmgr -c -d /dev/nvme0n1 -p 1 -L "Arch Linux" -l 'EFI\Linux\archlinux.efi'
```

## Setup

After finishing the installation, reboot, remove the installation medium and log in as root.

### NetworkManager

Enable and start NetworkManager.

```
systemctl enable --now NetworkManager
```

If required, use `nmtui` to connect to a wireless network.

### Pacman

Uncomment the parallel downloads and color options in `/etc/pacman.conf` and install additional packages.

```
pacman -S --needed base-devel git man-db pipewire pipewire-pulse polkit reflector ufw xorg-xinit xorg-server
```

Edit `/etc/xdg/reflector/reflector.conf` and uncomment `--country France,Germany`. Afterwards, start the timer to update the mirror list weekly.

```
systemctl enable --now reflector.timer
```

### Firewall

Configure the firewall to allow only traffic from 192.168.178.0/24 and rate limit ssh.

```
ufw default deny
ufw allow from 192.168.178.0/24
ufw limit ssh
```

Enable the firewall and show its status.

```
systemctl enable --now ufw
ufw enable
ufw status
```

### Create unprivileged user

Create the unprivileged user _julian_ and add it to the _sudo_ group.

```
groupadd -r sudo
useradd -m -G sudo julian
passwd julian
```

Execute `visudo` to edit `/etc/sudoers` and uncomment `%sudo ALL=(ALL:ALL) ALL`.

Log in as _julian_. If everything works as expected, disable the root login.

```
sudo passwd -l root
```

All following commands are executed as _julian_.

### Paru

Install and build `paru` as `pacman` wrapping AUR helper.

```
git clone https://aur.archlinux.org/paru.git ~/programs/paru
cd ~/programs/paru
makepkg -si
```

### Dotfiles

Finish the system setup by cloning the dotfiles, applying the configuration and changing the shell.

```
git clone https://github.com/julianschuler/dotfiles ~/documents/dotfiles
cd ~/documents/dotfiles
./apply-config -a
chsh -s /bin/fish julian
```

Reboot and log in as _julian_.

### Keyboard layout

Set a German keyboard layout with no dead keys and caps mapped to escape for X11 and the virtual console.

```
sudo localectl set-x11-keymap de "" nodeadkeys caps:escape
```

### Secure Boot

Go to the firmware settings and set the secure boot mode to `Setup mode`.

```
systemctl reboot --firmware-setup
```

Create and enroll the custom secure boot keys.

```
sudo sbctl create-keys
sudo sbctl enroll-keys -m
```

Regenerate and sign the unified kernel image(s).

```
sudo sbctl generate-bundles -s
```

Add a `pacman` hook to regenerate and sign the images upon kernel and initramfs changes by adding the file `/etc/pacmand.d/hooks/zz-sbctl.hook` containing the following:

```
[Trigger]
Type = Path
Operation = Install
Operation = Upgrade
Operation = Remove
Target = boot/*
Target = usr/lib/modules/*/vmlinuz
Target = usr/lib/initcpio/*
Target = usr/lib/**/efi/*.efi*

[Action]
Description = Regenerating and signing unified kernel images...
When = PostTransaction
Exec = /usr/bin/sbctl generate-bundles -s
```

Reboot again to the firmware settings and enable secure boot.

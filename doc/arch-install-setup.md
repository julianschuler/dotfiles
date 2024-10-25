# Arch Linux installation and setup

This document provides additional information for the installation and setup of Arch Linux according to the [Arch Wiki installation guide](https://wiki.archlinux.org/title/Installation_guide).
It assumes an installation to the NVMe drive /dev/nvme0n1 with an UEFI system and an encrypted root partition for a user _julian_ with a German keyboard layout.
The corresponding section of the installation guide which is replaced is given in parenthesis.

## Installation

Start by following sections 1.1 to 1.8 of the Arch Wiki installation guide. Afterwards, follow the next sections of this document.

### Partition the disks (1.9)

Securely erase the NVMe drive as described in the [Arch Wiki article](https://wiki.archlinux.org/title/Solid_state_drive/Memory_cell_clearing#NVMe_drive).

Start `parted` and create a new GUID Partition Table.

```sh
parted /dev/nvme0n1
(parted) mklabel gpt
```

Afterwards, create the EFI and root partitions.

```sh
(parted) mkpart efi fat32 0% 512MiB
(parted) set 1 esp on
(parted) mkpart root btrfs 512MiB 100%
```

#### Encrypt the root partition

Encrypt the root partition with dm-crypt and unlock it.

```sh
cryptsetup luksFormat /dev/nvme0n1p2
cryptsetup open /dev/nvme0n1p2 root
```

### Format the partitions (1.10)

Format the EFI partitions to FAT32 and the root partition to btrfs.

```sh
mkfs.fat -F 32 /dev/nvme0n1p1
mkfs.btrfs /dev/mapper/root
```

### Mount the partitions (1.11)

Mount the partitions to `/mnt/efi` and `/mnt` respectively.

```sh
mount /dev/mapper/root /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/efi
```

### Essential packages (2.2)

Select the microcode package according to your CPU manufacturer (AMD or Intel).

```sh
pacstrap /mnt base efibootmgr linux linux-firmware btrfs-progs networkmanager vi {amd|intel}-ucode
```

From now on, follow section 3.1 to 3.5 of the Arch Wiki installation guide.

### Initramfs (3.6)

Change the `HOOKS=(...)` line in `/etc/mkinitcpio.conf` to

```sh
HOOKS=(base udev autodetect microcode modconf kms keyboard keymap block encrypt filesystems)
```

Enable lz4 compression by uncommenting `COMPRESSION=lz4` and setting `COMPRESSION_OPTIONS=(-9)`.

The initramfs is regenerated later in section 3.8.

### Root password (3.7)

Set the root password to something simple (the root login will be disabled during setup).

```sh
passwd
```

### Boot loader (3.8)

Add the file `/etc/kernel/cmdline` with the following line and `<device-uuid>` set to the UUID of /dev/nvme0n1p2.

```
cryptdevice=UUID=<device-uuid>:root root=/dev/mapper/root rw quiet bgrt_disable
```

Change the content of `/etc/mkinitcpio.d/linux.preset` to the following:

```
# mkinitcpio preset file for the 'linux' package

ALL_config="/etc/mkinitcpio.conf"
ALL_kver="/boot/vmlinuz-linux"

PRESETS=('default')

default_uki="/efi/EFI/Linux/arch-linux.efi"
default_options="--splash=/usr/share/systemd/bootctl/splash-arch.bmp"
```

Regenerate the initramfs to build the unified kernel image.

```sh
mkdir -p /efi/EFI/Linux
mkinitcpio -P
```

Finally, add an EFI entry for the created image.

```sh
efibootmgr -c -d /dev/nvme0n1 -p 1 -L "Arch Linux" -l 'EFI\Linux\arch-linux.efi'
```

## Setup

After finishing the installation, reboot, remove the installation medium and log in as root.

### NetworkManager

Enable and start NetworkManager.

```sh
systemctl enable --now NetworkManager
```

If required, use `nmtui` to connect to a wireless network.

### Pacman

Uncomment the parallel downloads and color options in `/etc/pacman.conf` and install additional packages.

```sh
pacman -S --needed base-devel git man-db pipewire pipewire-pulse polkit reflector ufw
```

Edit `/etc/xdg/reflector/reflector.conf` and uncomment `--country France,Germany`. Afterwards, start the timer to update the mirror list weekly.

```sh
systemctl enable --now reflector.timer
```

### Firewall

Configure the firewall to allow only traffic from 192.168.178.0/24 and rate limit ssh.

```sh
ufw default deny
ufw allow from 192.168.178.0/24
ufw limit ssh
```

Enable the firewall and show its status.

```sh
systemctl enable --now ufw
ufw enable
ufw status
```

### Create unprivileged user

Create the unprivileged user _julian_ and add it to the _sudo_ group.

```sh
groupadd -r sudo
useradd -m -G sudo julian
passwd julian
```

Execute `visudo` to edit `/etc/sudoers` and uncomment `%sudo ALL=(ALL:ALL) ALL`.

Log in as _julian_. If everything works as expected, disable the root login.

```sh
sudo passwd -l root
```

All following commands are executed as _julian_.

### Paru

Install and build `paru` as `pacman` wrapping AUR helper.

```sh
git clone https://aur.archlinux.org/paru.git ~/programs/paru
cd ~/programs/paru
makepkg -si
```

### Dotfiles

Finish the system setup by cloning the dotfiles, applying the configuration and changing the shell.

```sh
git clone https://github.com/julianschuler/dotfiles ~/documents/dotfiles
cd ~/documents/dotfiles
./apply-config -a
chsh -s /bin/fish julian
```

Reboot and log in as _julian_.

### Keyboard layout

Set a German keyboard layout with no dead keys and caps mapped to escape for X11 and the virtual console.

```sh
sudo localectl set-x11-keymap de "" nodeadkeys caps:escape
```

### Secure Boot

Install `sbctl`.

```sh
sudo pacman -S sbctl
```

Reboot into the firmware settings and set the secure boot mode to `Setup mode`.

```sh
systemctl reboot --firmware-setup
```

Create and enroll custom secure boot keys.

```sh
sudo sbctl create-keys
sudo sbctl enroll-keys -m
```

Regenerate the unified kernel image to trigger the `sbctl` hook signing it.

```sh
sudo mkinitcpio -P
```

Reboot again to the firmware settings and enable secure boot.

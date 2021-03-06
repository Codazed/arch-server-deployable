#!/bin/bash
bootloader_efi() {
  echo "Installing systemd-boot..."
  bootctl install
  sed -i '/^HOOKS=/ s/)/ systemd)/' /etc/mkinitcpio.conf
  mkinitcpio -P
}

bootloader_mbr() {
  echo "Installing GRUB..."
  firstdisk=$(lsblk | grep disk | head -n 1 | cut -d ' ' -f 1)
  pacman -S grub --noconfirm
  grub-install --target=i386-pc /dev/${firstdisk}
  sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=/ s/"$/ console=tty0 console=ttyS0,115200"/' /etc/default/grub
  grub-mkconfig -o /boot/grub/grub.cfg
}

if [[ $(ls /sys/firmware/efi/efivars 2>/dev/null) ]]; then
  bootloader_efi
else
  bootloader_mbr
fi
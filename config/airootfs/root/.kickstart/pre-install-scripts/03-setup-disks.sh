#!/bin/bash

if [[ $(ls /sys/firmware/efi/efivars 2>/dev/null) ]]; then
  efisys=true
else
  efisys=false
fi

firstdisk=$(lsblk | grep disk | head -n 1 | cut -d ' ' -f 1)

partition_efi() {
  log_info "Partitioning /dev/${firstdisk}..."
  log_info "Creating new GPT partition table"
  parted /dev/${firstdisk} mklabel gpt 
  log_info "Creating ESP partition"
  parted /dev/${firstdisk} mkpart "EFI" fat32 1MiB 512MiB
  parted /dev/${firstdisk} set 1 esp on
  log_info "Creating Swap partition"
  parted /dev/${firstdisk} mkpart "Swap" linux-swap 512MiB 4.5GiB
  parted /dev/${firstdisk} set 2 swap on
  log_info "Creating Root partition"
  parted /dev/${firstdisk} mkpart "Root" xfs 4.5GiB 100%
}

partition_mbr() {
  log_info "Partitioning /dev/${firstdisk}..."
  log_info "Creating new DOS partition table"
  parted /dev/${firstdisk} mklabel msdos
  log_info "Creating Swap partition"
  parted /dev/${firstdisk} mkpart primary linux-swap 1MiB 4GiB
  log_info "Creating Root partition"
  parted /dev/${firstdisk} mkpart primary xfs 4GiB 100%
  parted /dev/${firstdisk} set 1 boot on
}

format_efi() {
  log_info "Formatting partitions on /dev/${firstdisk}..."
  mkfs.fat /dev/${firstdisk}1
  mkswap /dev/${firstdisk}2
  mkfs.xfs /dev/${firstdisk}3
}

format_mbr() {
  log_info "Formatting partitions on /dev/${firstdisk}..."
  mkswap /dev/${firstdisk}1
  mkfs.xfs /dev/${firstdisk}2
}

mount_efi() {
  log_info "Mounting partitions..."
  mount /dev/${firstdisk}3 /mnt
  mkdir /mnt/boot
  mount /dev/${firstdisk}1 /mnt/boot
  swapon /dev/${firstdisk}2
}

mount_mbr() {
  log_info "Mounting partitions..."
  mount /dev/${firstdisk}2 /mnt
  swapon /dev/${firstdisk}1
}

if [[ $efisys=="true" ]]; then
  partition_efi
  format_efi
  mount_efi
else
  partition_mbr
  format_mbr
  mount_mbr
fi


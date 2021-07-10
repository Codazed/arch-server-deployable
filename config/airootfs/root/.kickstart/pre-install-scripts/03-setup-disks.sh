#!/bin/bash

partition_efi() {
  log_info "Partitioning /dev/sda..."
  log_info "Creating new GPT partition table"
  parted /dev/sda mklabel gpt 
  log_info "Creating ESP partition"
  parted /dev/sda mkpart "EFI" fat32 1MiB 512MiB
  parted /dev/sda set 1 esp on
  log_info "Creating Swap partition"
  parted /dev/sda mkpart "Swap" linux-swap 512MiB 4.5GiB
  parted /dev/sda set 2 swap on
  log_info "Creating Root partition"
  parted /dev/sda mkpart "Root" xfs 4.5GiB 100%
  parted /dev/sda set 3 root on
}

partition_mbr() {
  log_info "Partitioning /dev/sda..."
  log_info "Creating new DOS partition table"
  parted /dev/sda mklabel msdos
  log_info "Creating Swap partition"
  parted /dev/sda mkpart primary linux-swap 1MiB 4GiB
  log_info "Creating Root partition"
  parted /dev/sda mkpart primary xfs 4GiB 100%
  parted /dev/sda set 1 boot on
}

format_efi() {
  log_info "Formatting partitions on /dev/sda..."
  mkfs.fat /dev/sda1
  mkswap /dev/sda2
  mkfs.xfs /dev/sda3
}

format_mbr() {
  log_info "Formatting partitions on /dev/sda..."
  mkswap /dev/sda1
  mkfs.xfs /dev/sda2
}

mount_efi() {
  log_info "Mounting partitions..."
  mount /dev/sda3 /mnt
  mkdir /mnt/boot
  mount /dev/sda1 /mnt/boot
  swapon /dev/sda2
}

mount_mbr() {
  log_info "Mounting partitions..."
  mount /dev/sda2 /mnt
  swapon /dev/sda1
}

if [[ $efisys ]]; then
  partition_efi
  format_efi
  mount_efi
else
  partition_mbr
  format_mbr
  mount_mbr
fi


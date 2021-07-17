if [[ $(ls /sys/firmware/efi/efivars 2>/dev/null) ]]; then
  cp systemd-bootentry.conf /mnt/boot/loader/entries/
fi
if [[ $(ls /sys/firmware/efi/efivars 2>/dev/null) ]]; then
  efisys=true
else
  efisys=false
fi

if [[ $efisys ]]; then
  cp systemd-bootentry.conf /mnt/boot/loader/entries/
fi
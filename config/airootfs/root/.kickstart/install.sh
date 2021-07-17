# Load installer library
source ./lib.sh

log_info "Starting automated install"
sleep 5
log_info "Running pre-install scripts"
for script in $(find pre-install-scripts -iname *.sh -type f)
do
  log_info "-$(basename $script)"
  source $script
  log_pass "+$(basename $script)"
done
log_pass "Finished running pre-install scripts"
sleep 3

log_info "Pacstrapping system..."
pacstrap /mnt - < pacstrap.txt
log_pass "Pacstrapping complete"
sleep 3

log_info "Generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab

log_info "Running post-install scripts"
for script in $(find post-install-scripts -iname *.sh -type f)
do
  log_info "-$(basename $script)"
  cat $script | arch-chroot /mnt bash
  log_pass "+$(basename $script)"
done
log_pass "Finished running post-install scripts"
sleep 3
log_info "Running post-chroot scripts"
for script in $(find post-chroot-scripts -iname *.sh -type f)
do
  log_info "-$(basename $script)"
  source $script
  log_pass "+$(basename $script)"
done
log_pass "Finished running post-chroot scripts"
sleep 3
log_info "Unmounting file systems"
umount -R /mnt
log_succ "Arch Linux has been deployed! Restarting system in 10 seconds"
sleep 10
reboot

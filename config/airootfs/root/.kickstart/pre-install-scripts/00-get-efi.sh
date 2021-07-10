#!/bin/bash

log_info "Checking to see if system is an EFI system..."
if [[ $(ls /sys/firmware/efi/efivars 2>/dev/null) ]]; then
  efisys=true
  log_info "This is an EFI system"
else
  efisys=false
  log_info "This is an MBR system"
fi
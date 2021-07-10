#!/bin/bash

log_info "Checking internet connectivity"

if [[ $(ping archlinux.org -c 8) ]]; then
  log_info "Internet connectivity is fine"
else
  log_warn "Internet connectivity is not good; pacstrap may fail."
fi
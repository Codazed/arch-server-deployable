#!/bin/bash
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru
su nobody -c "makepkg -si"

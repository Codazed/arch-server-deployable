#!/bin/bash
git clone https://aur.archlinux.org/paru.git /root/paru
cd /root/paru
makepkg -si

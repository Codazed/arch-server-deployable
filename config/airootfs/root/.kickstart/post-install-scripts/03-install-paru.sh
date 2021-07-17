#!/bin/bash
pacman -S git --noconfirm
git clone https://aur.archlinux.org/paru.git /tmp/paru
chown -R nobody:nobody /tmp/paru
nobodyshell=$(cat /etc/passwd | grep nobody | cut -d ':' -f 7)
chsh nobody -s /bin/bash
cd /tmp/paru
su nobody -c "makepkg -si"
chsh nobody -s $nobodyshell

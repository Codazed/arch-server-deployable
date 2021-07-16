#!/bin/bash
git clone https://aur.archlinux.org/paru.git /tmp/paru
nobodyshell=$(cat /etc/passwd | grep nobody | cut -d ':' -f 7)
chsh nobody -s /bin/bash
cd /tmp/paru
su nobody -c "makepkg -si"
chsh nobody -s $nobodyshell

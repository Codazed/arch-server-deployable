FROM archlinux:latest
RUN pacman -Syu --noconfirm
RUN pacman -S pacman-contrib --noconfirm
# Get good mirrors
RUN curl -s "https://archlinux.org/mirrorlist/?country=US&protocol=http&protocol=https&ip_version=4" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 10 - | tee /etc/pacman.d/mirrorlist
RUN pacman -S archiso --noconfirm

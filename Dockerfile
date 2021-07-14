FROM archlinux:latest
# Get good mirrors
RUN curl -s "https//archlinux.org/mirrorlist/?country=AU&country=DE&country=NL&country=NZ&country=CH&country=GB&country=US&protocol=http&protocol=https&ip_version=4" | sed -e 's/#Server/Server/' -e '/^#/d' | rankmirrors -n 10 - > /etc/pacman.d/mirrorlist
RUN pacman -Syu --noconfirm
RUN pacman -S archiso --noconfirm

FROM archlinux:latest
RUN pacman -Syu --noconfirm
RUN pacman -S archiso --noconfirm

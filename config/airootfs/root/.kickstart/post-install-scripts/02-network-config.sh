#!/bin/bash

echo "arch-deployed" > /etc/hostname
cat <<EOT >> /etc/hosts
127.0.0.1        localhost
::1              localhost
127.0.1.1        arch-deployed.localdomain arch-deployed
EOT
pacman -S dhcpcd --noconfirm
systemctl enable dhcpcd
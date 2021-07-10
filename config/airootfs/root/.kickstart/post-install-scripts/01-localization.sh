#!/bin/bash

sed -i '/en_US.UTF-8/s/^#//g' /etc/locale.gen
echo LANG=en_US.UTF-8 > /etc/locale.conf

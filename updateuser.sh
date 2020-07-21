#!/bin/bash
user=`egrep '1[0-9]{3}' /etc/passwd | cut -d \: -f1`
apt update && echo "$user  ALL=(ALL:ALL) ALL" >> /etc/sudoers
version=`./dist.sh`
case "$version" in
        linuxmint|mint)
  sudo ./mint.sh
        ;;
        debian)
  sudo ./debian.sh
        ;;
	ubuntu)
  sudo ./ubuntu.sh
	;;
esac

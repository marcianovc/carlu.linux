#!/bin/bash
$user = `egrep '1[0-9]{3}' /etc/passwd | cut -d \: -f1`
apt update && adduser $user sudo
version=`./dist.sh`
case "$version" in
        ubuntu|linuxmint|mint)
  sudo ./mint.sh
        ;;
        debian)
  sudo ./debian.sh
        ;;
esac
